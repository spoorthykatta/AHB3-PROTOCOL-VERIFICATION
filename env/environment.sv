class environment extends uvm_env;
`uvm_component_utils(environment)

agent agt;
scoreboard scbd;
subscriber sub;

function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

uvm_config_db#(uvm_active_passive_enum)::set(this,"agt","is_active",UVM_ACTIVE);

agt=agent::type_id::create("agt",this);
scbd=scoreboard::type_id::create("scbd",this);
sub=subscriber::type_id::create("sub",this);

`uvm_info(get_type_name(),"environment build_phase completed",UVM_LOW)
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
agt.mon.mon_ap.connect(scbd.sb_imp);
agt.mon.mon_ap.connect(sub.analysis_export);
`uvm_info(get_type_name(),"environment connect_phase completed",UVM_LOW)
endfunction
endclass




