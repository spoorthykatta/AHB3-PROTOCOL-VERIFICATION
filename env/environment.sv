class environment extends uvm_env;
`uvm_component_utils(environment)

scoreboard scbd;
subscriber sub;
agent agt;

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

uvm_config_db#(uvm_active_passive_enum)::set(this,"agt","is_active",UVM_ACTIVE);

agt=agent::type_id::create("agt",this);
scbd=scoreboard::type_id::create("scbd",this);
sub=subscriber::type_id::create("sub",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
agt.mon.mon_ap.connect(scbd.sb_imp);
agt.mon.mon_ap.connect(sub.analysis_export);
endfunction
endclass

