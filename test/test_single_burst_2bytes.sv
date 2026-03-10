class test_single_burst_2bytes extends uvm_test;
`uvm_component_utils(test_single_burst_2bytes)

environment env;
seq_single_burst_2bytes seq;

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
seq=seq_single_burst_2bytes::type_id::create("seq");
seq.start(env.agt.seqr);
#100;

phase.drop_objection(this);
endtask
endclass


