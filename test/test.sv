class test extends uvm_test;
`uvm_component_utils(test)

environment env;
sequencee seq;

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
env=environment::type_id::create("env",this);
endfunction

virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
phase.raise_objection(this);
seq=sequencee::type_id::create("seq");
seq.start(env.agt.seqr);
#100;

phase.drop_objection(this);
endtask
endclass
