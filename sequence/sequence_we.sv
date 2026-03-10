class sequence_we extends uvm_sequence#(seq_item);

`uvm_object_utils(sequence_we)
seq_item req;


function new(string name="sequence_we");
super.new(name);
endfunction

task body();
//write error
req=seq_item::type_id::create("req");

`uvm_info(get_type_name(),"write sequence_we started",UVM_NONE)

start_item(req);
assert(req.randomize() with {
                            req.pwrite==1;
							req.paddr>255;
                            });
`uvm_info(get_type_name(),$sformatf("SEQ: paddr=0x%0h pwrite=%0b pwdata=0x%0h",
          req.paddr, req.pwrite, req.pwdata),UVM_NONE)
finish_item(req);

`uvm_info(get_type_name(),"write sequence_we finished",UVM_NONE)

endtask
endclass


