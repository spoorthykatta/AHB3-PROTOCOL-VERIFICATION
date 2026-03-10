class test_rw extends uvm_test;
	`uvm_component_utils(test_rw)

	environment env;
	sequence_rw seq;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env=environment::type_id::create("env",this);
	`uvm_info(get_type_name(),"test_rw build_phase completed",UVM_LOW)
endfunction

virtual task run_phase(uvm_phase phase);
super.run_phase(phase);

phase.raise_objection(this);
seq=sequence_rw::type_id::create("seq");
`uvm_info(get_type_name(),"starting apb sequence_rw",UVM_LOW)
seq.start(env.agt.seqr);
`uvm_info(get_type_name(),"apb sequence_rw completed",UVM_LOW)
phase.drop_objection(this);
endtask
endclass

