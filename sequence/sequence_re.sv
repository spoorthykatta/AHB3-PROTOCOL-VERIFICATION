class sequence_re extends uvm_sequence#(seq_item);

`uvm_object_utils(sequence_re)
seq_item req;


function new(string name="sequence_re");
super.new(name);
endfunction

task body();
//read error
req=seq_item::type_id::create("req");

`uvm_info(get_type_name(),"read sequence_re started",UVM_NONE)

start_item(req);
assert(req.randomize() with {
                            req.pwrite==0;
                            req.paddr>255;
                          });
`uvm_info(get_type_name(),$sformatf("SEQ: paddr=0x%0h pwrite=%0b prdata=0x%0h",
          req.paddr, req.pwrite, req.prdata),UVM_NONE)
finish_item(req);

`uvm_info(get_type_name(),"read sequence_re finished",UVM_NONE)

endtask
endclass

