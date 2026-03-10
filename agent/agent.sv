class agent extends uvm_agent;
`uvm_component_utils(agent)

sequencer seqr;
driver drv;
monitor mon;

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(uvm_active_passive_enum)::get(this,"","is_active",is_active))
`uvm_fatal(get_type_name(),"is_active not set in agent via config db")

if(is_active==UVM_ACTIVE)begin
seqr=sequencer::type_id::create("seqr",this);
drv=driver::type_id::create("drv",this);
end

mon=monitor::type_id::create("mon",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(is_active==UVM_ACTIVE)begin
drv.seq_item_port.connect(seqr.seq_item_export);
end
endfunction

endclass
