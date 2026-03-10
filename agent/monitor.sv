class monitor extends uvm_monitor;
`uvm_component_utils(monitor)

virtual ahb_if vif;
seq_item mon_tr;
uvm_analysis_port#(seq_item)mon_ap;
int i;

function new(string name,uvm_component parent);
super.new(name,parent);
mon_ap=new("mon_ap",this);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info(get_type_name(),"Monitor build_phase started",UVM_LOW)
if(!uvm_config_db#(virtual ahb_if)::get(this,"","vif",vif))
`uvm_fatal(get_type_name(),"config db not set in monitor")
else
`uvm_info(get_type_name(),"Monitor build_phase completed",UVM_LOW)
endfunction

function int get_beats(bit [2:0] hburst);
   case(hburst)
      3'b000: return 1;
      3'b001: return 10;
      3'b010,3'b011: return 4;
      3'b100,3'b101: return 8;
      3'b110,3'b111: return 16;
   endcase
endfunction

virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
`uvm_info(get_type_name(),"Monitor run_phase started",UVM_LOW)

forever begin
//wait for valid transfer (address phase)
@(vif.mon_cb);
if(vif.mon_cb.hready && vif.mon_cb.hsel && (vif.mon_cb.htrans == 2'b00 || vif.mon_cb.htrans == 2'b01))begin
//if(vif.mon_cb.hready)begin

mon_tr=seq_item::type_id::create("mon_tr");

mon_tr.haddr=vif.mon_cb.haddr;
mon_tr.hwrite=vif.mon_cb.hwrite;
mon_tr.hsize=vif.mon_cb.hsize;
mon_tr.hburst=vif.mon_cb.hburst;
mon_tr.hsel=vif.mon_cb.hsel;
mon_tr.htrans=vif.mon_cb.htrans;
mon_tr.hresp=vif.mon_cb.hresp;

mon_tr.no_of_beats = get_beats(mon_tr.hburst);
//mon_tr.hrdata = new[mon_tr.no_of_beats];

//--------write----------
if(mon_tr.hwrite)begin
for(int i=0;i<mon_tr.no_of_beats;i++)begin
@(vif.mon_cb);
mon_tr.hwdata[i]=vif.mon_cb.hwdata;
end
`uvm_info(get_type_name(),$sformatf("MON WRITE:addr=0x%0h hwrite=%0b hsize=%0b hburst=%0b htrans=%0b hwdata=%p hresp=%0b",mon_tr.haddr, mon_tr.hwrite, mon_tr.hsize, mon_tr.hburst, mon_tr.htrans, mon_tr.hwdata, mon_tr.hresp),UVM_LOW)
end

else begin

for(int i=0;i<mon_tr.no_of_beats;i++)begin
@(vif.mon_cb);
mon_tr.hrdata[i]=vif.mon_cb.hrdata;
//mon_tr.hrdata.push_back(vif.mon_cb.hrdata);
end
`uvm_info(get_type_name(),$sformatf("MON READ:addr=0x%0h hwrite=%0b hsize=%0b hburst=%0b htrans=%0b hrdata=%p hresp=%0b",mon_tr.haddr, mon_tr.hwrite, mon_tr.hsize, mon_tr.hburst, mon_tr.htrans, mon_tr.hrdata, mon_tr.hresp),UVM_LOW)
end

mon_ap.write(mon_tr);

`uvm_info(get_type_name(),"Monitor run_phase completed",UVM_LOW)
end
end
endtask
endclass


