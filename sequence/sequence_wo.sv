class sequence_wo extends uvm_sequence#(seq_item);

`uvm_object_utils(sequence_wo)
seq_item req;


function new(string name="sequence_wo");
super.new(name);
endfunction

task body();
repeat(5)begin
//write only
req=seq_item::type_id::create("req");

`uvm_info(get_type_name(),"write sequence_wo started",UVM_NONE)

start_item(req);
assert(req.randomize() with {
                            req.pwrite==1;
							req.paddr inside {[0:255]};
                          });
`uvm_info(get_type_name(),$sformatf("SEQ: paddr=0x%0h pwrite=%0b pwdata=0x%0h",
          req.paddr, req.pwrite, req.pwdata),UVM_NONE)
finish_item(req);

`uvm_info(get_type_name(),"write sequence_wo finished",UVM_NONE)
end
endtask
endclass



