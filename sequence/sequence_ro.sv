class sequence_ro extends uvm_sequence#(seq_item);

`uvm_object_utils(sequence_ro)
seq_item req;


function new(string name="sequence_ro");
super.new(name);
endfunction

task body();
//read only
repeat(5)begin
req=seq_item::type_id::create("req");

`uvm_info(get_type_name(),"read sequence_ro started",UVM_NONE)

start_item(req);
assert(req.randomize() with {
                            req.pwrite==0;
							req.paddr inside {[0:255]};
                          });
`uvm_info(get_type_name(),$sformatf("SEQ: paddr=0x%0h pwrite=%0b pwdata=0x%0h",
          req.paddr, req.pwrite, req.pwdata),UVM_NONE)
finish_item(req);

`uvm_info(get_type_name(),"read sequence_ro finished",UVM_NONE)
end
endtask
endclass




