class sequence_rw extends uvm_sequence#(seq_item);

`uvm_object_utils(sequence_rw)
seq_item req;
bit [31:0] queue[$];


function new(string name="sequence_rw");
super.new(name);
endfunction

task body();
repeat(2)
begin
req=seq_item::type_id::create("req");

`uvm_info(get_type_name(),"write sequence_rw started",UVM_NONE)

start_item(req);
assert(req.randomize() with {
                            req.pwrite==1;
			    req.paddr inside {[0:255]};
                          });
`uvm_info(get_type_name(),$sformatf("SEQ: paddr=0x%0h pwrite=%0b pwdata=0x%0h",
          req.paddr, req.pwrite, req.pwdata),UVM_NONE)
		  queue.push_back(req.paddr);
finish_item(req);

`uvm_info(get_type_name(),"write sequence_rw finished",UVM_NONE)
end

repeat(2)begin
req=seq_item::type_id::create("req");

`uvm_info(get_type_name(),"read sequence_rw started",UVM_NONE)

start_item(req);
assert(req.randomize() with {
                            req.pwrite==0;
                          });
			    req.paddr=queue.pop_front();

`uvm_info(get_type_name(),$sformatf("SEQ: paddr=0x%0h pwrite=%0b",
          req.paddr, req.pwrite),UVM_NONE)
		  finish_item(req);

`uvm_info(get_type_name(),"read sequence_rw finished",UVM_NONE)
end
endtask
endclass


