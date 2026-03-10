class monitor extends uvm_monitor;
`uvm_component_utils(monitor)

virtual apb_if vif;
uvm_analysis_port#(seq_item) mon_ap;
seq_item mon_tr;

function new(string name,uvm_component parent);
super.new(name,parent);
mon_ap=new("mon_ap",this);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
`uvm_fatal(get_type_name(),"virtual interface not set for monitor")
else
`uvm_info(get_type_name(),"monitor build_phase completed",UVM_LOW)
endfunction

virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
`uvm_info(get_type_name(),"monitor run_phase started",UVM_LOW)

forever begin
@(vif.mon_cb);
if(vif.mon_cb.psel && vif.mon_cb.pen && vif.mon_cb.pready)begin
mon_tr=seq_item::type_id::create("mon_tr");

mon_tr.paddr=vif.mon_cb.paddr;
mon_tr.pwrite=vif.mon_cb.pwrite;
mon_tr.pslverr=vif.mon_cb.pslverr;

if(mon_tr.pwrite)begin
mon_tr.pwdata=vif.mon_cb.pwdata;
`uvm_info(get_type_name(),$sformatf("MON write: addr=0x%0h pwrite=%0b pwdata=0x%0h err=%0b",mon_tr.paddr,mon_tr.pwrite, mon_tr.pwdata, mon_tr.pslverr),UVM_LOW)
end

else begin
mon_tr.prdata=vif.mon_cb.prdata;
`uvm_info(get_type_name(),$sformatf("MON write: addr=0x%0h pwrite=%0b prdata=0x%0h err=%0b",mon_tr.paddr,mon_tr.pwrite, mon_tr.prdata, mon_tr.pslverr),UVM_LOW)
end

mon_ap.write(mon_tr);//send to scoreboard

end
end
endtask
endclass



