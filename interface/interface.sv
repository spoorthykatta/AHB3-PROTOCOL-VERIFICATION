interface ahb_if(input bit hclk,hresetn);

//master signals
logic [31:0] hwdata;
logic [31:0] haddr;
logic [2:0] hsize;
logic [2:0] hburst;
logic hsel; 
logic hwrite;
logic [1:0] htrans;

//slave signals
logic [1:0] hresp;
logic hready;
logic [31:0] hrdata;

//-------------------------
//driver clocking block
//--------------------------
clocking drv_cb@(posedge hclk);
default output #0 input #1;

output hwdata,haddr,hsize,hburst,hsel,hwrite,htrans;
input hresp,hready,hrdata;
endclocking

//-----------------------
//monitor clocking block
//-----------------------
clocking mon_cb@(posedge hclk);
default input #1;

input hwdata,haddr,hsize,hburst,hsel,hwrite,htrans,hresp,hready,hrdata;
endclocking

//----------------
//modports
//-----------------
modport driver(clocking drv_cb, input hresetn);

modport monitor(clocking mon_cb, input hresetn);

modport dut(input hclk,hresetn,hwdata,haddr,hsize,hburst,hsel,hwrite,htrans,
            output hresp,hready,hrdata);

//----ASSERTIONS------

//---------idle state

property idle_state;
@(posedge hclk)
hresetn |-> (hsel==0 && hready==0 && hresp==0);
endproperty
assert property(idle_state)
else $warning("RESET STATE ERROR");

//-----starting burst NONSEQ

property first_nonseq;
@(posedge hclk)
(hburst!=3'b000) |-> (htrans==2'b00); //if burst length>0 first transfer should be non seq
endproperty

assert property(first_nonseq)
else $warning("FIRST BURST IN NOT NONSEQ");


//---SEQ follows NON SEQ burst

property seq_after_nonseq;
@(posedge hclk)
(htrans==2'b01) |-> $past(htrans) inside{2'b00, 2'b01};
endproperty

assert property(seq_after_nonseq)
else $warning("SEQ TRANS WITHOUT NONSEQ TRANS");


//----no SEQ for single burst

property single_no_seq;
@(posedge hclk)
(hburst==3'b000 && htrans==2'b00) |=> (htrans!==2'b01);
endproperty

assert property(single_no_seq)
else $warning("SEQ IN SINGLE TRANSFER");

//------address allignment

property address_alignment;
@(posedge hclk)
((hsize==3'b000) || (hsize==3'b001 && haddr[0] == 0) || (hsize==3'b010 && haddr[1:0] == 0));
endproperty

assert property(address_alignment)
else $warning("ADDRESS NOT ALIGNED");

/*//------1kb boundary---

property kb_boundary;
@(posedge hclk)
(hburst!=3'b000) |-> ((haddr[9:0] + (no_of_beats * beat_size())-1) < 1024);
endproperty

assert property(kb_boundary)
else $warning("CROSSED 1KB BOUNDARY");*/


			
endinterface




