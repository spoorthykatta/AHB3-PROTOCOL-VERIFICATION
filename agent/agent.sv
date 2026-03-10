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

//get is_active from config db
if(!uvm_config_db#(uvm_active_passive_enum)::get(this,"","is_active",is_active))
begin
`uvm_fatal(get_type_name(),"is_active not set for agent via config_db")
end
//create components based on is_active
if(is_active==UVM_ACTIVE)begin	
seqr=sequencer::type_id::create("seqr",this);
drv=driver::type_id::create("drv",this);
end

mon=monitor::type_id::create("mon",this);//monitor is always created

`uvm_info(get_type_name(),$sformatf("agent build_phase completed,is_active=%s",is_active.name()),UVM_LOW)

endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);

if(is_active==UVM_ACTIVE)begin
drv.seq_item_port.connect(seqr.seq_item_export);
end
`uvm_info(get_type_name(),"agent connect_phase completed",UVM_LOW)
endfunction

endclass
