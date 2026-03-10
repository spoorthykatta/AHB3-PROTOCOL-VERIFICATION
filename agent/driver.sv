class driver extends uvm_driver#(seq_item);
`uvm_component_utils(driver)

virtual ahb_if vif;
seq_item req;

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info(get_type_name(),"driver build_phase started",UVM_LOW)
if(!uvm_config_db#(virtual ahb_if)::get(this,"","vif",vif))
`uvm_fatal(get_type_name(),"Virtual interface not set in driver")
else
`uvm_info(get_type_name(),"driver build_phase completed",UVM_LOW)
endfunction

virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
`uvm_info(get_type_name(),"driver run_phase started",UVM_LOW)

reset_bus();
//@(vif.drv_cb);//if this delay is added extra clk delay will be there for first transfer

forever begin
seq_item_port.get_next_item(req);
drive(req);
seq_item_port.item_done(req);
`uvm_info(get_type_name(),"driver run_phase completed",UVM_LOW)
end
endtask

task reset_bus();
vif.hwdata=0;
vif.haddr=0;
vif.hsize=0;
vif.hburst=0;
vif.hsel=0;
vif.hwrite=0;
vif.htrans=0;
endtask

task drive(seq_item req);
fork
address_phase(req);
@(vif.drv_cb)
data_phase(req);
join
endtask

task address_phase(seq_item req);
vif.drv_cb.haddr<=req.haddr;
vif.drv_cb.hsize<=req.hsize;
vif.drv_cb.hburst<=req.hburst;
vif.drv_cb.hsel<=1'b1;
vif.drv_cb.hwrite<=req.hwrite;
//vif.drv_cb.htrans<=req.htrans;
address_calculation(req);
endtask

/*//-------BEAT SIZE-------
function int beat_size(seq_item req);
case(req.hsize)
3'b000: return 1;//byte
3'b001: return 2;//halfword
3'b010: return 4;//word
default: return 1;
endcase
endfunction*/

task address_calculation(seq_item req);
//int no_of_beats;
bit [31:0] n_addr;
int wrap_boundary;
int start_addr;

n_addr=req.haddr;//first addr
wrap_boundary=req.no_of_beats*req.beat_size();
//start_addr=$clog2(wrap_boundary);//starting is generated at boundary everytime and same increments even when kept in repeat
start_addr=(n_addr/wrap_boundary)*wrap_boundary;

//--------NO OF BEATS(BURST)----------
/*case(req.hburst)
  3'b001: no_of_beats=10;//UNDEFINED INCR	
  3'b010: no_of_beats=4;//WRAP4
  3'b011: no_of_beats=4;//INCR4
  3'b100: no_of_beats=8;//WRAP8
  3'b101: no_of_beats=8;//INCR8
  3'b110: no_of_beats=16;//WRAP16
  3'b111: no_of_beats=16;//INCR16
  default: no_of_beats=1;
endcase*/

for(int i=0;i<req.no_of_beats;i++)begin
@(vif.drv_cb);
vif.drv_cb.haddr<=n_addr;//address per beat
vif.drv_cb.htrans<=(i==0)?2'b00:2'b01;//if i=0(nonseq), else seq
/*if(i==0)begin
vif.drv_cb.htrans<=2'b00;
end
else begin
vif.drv_cb.htrans<=2'b01;
end*/
//`uvm_info(get_type_name(),$sformatf("DRV: Beat[%0d] :: Address = 0x%0h", i, n_addr),UVM_LOW)

if(req.hburst inside {3'b001,3'b011, 3'b101, 3'b111})begin//except wrap
n_addr=n_addr+req.beat_size();
end
else if(req.hburst inside {3'b010, 3'b100, 3'b110})begin//wrap
n_addr=n_addr+req.beat_size();
if(n_addr>=start_addr+wrap_boundary)//if address crosses boundary
//if(n_addr>=start_addr+wrap_boundary-req.no_of_beats)//if address crosses boundary
n_addr=start_addr;//it should wrap around to start address
end
end
endtask

task data_phase(seq_item req);
int i;
if(req.hwrite)begin
for(int i=0;i<req.no_of_beats;i++)begin
@(vif.drv_cb)
vif.drv_cb.hwdata<=req.hwdata[i];
end
`uvm_info(get_type_name(),$sformatf("DRV SENT:wdata=%0p",req.hwdata),UVM_LOW)

end
else 
for(int i=0;i<req.no_of_beats;i++)
vif.drv_cb.hwdata<=0;
endtask


endclass
