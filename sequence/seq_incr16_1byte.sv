class seq_incr16_1byte extends uvm_sequence#(seq_item);
`uvm_object_utils(seq_incr16_1byte)

seq_item req;

function new(string name="seq_incr16_1byte");
super.new(name);
endfunction

task body();

//-----------SIZE 1 BYTE-----------------

req=seq_item::type_id::create("req");

begin
`uvm_info(get_type_name(),"write sequence has started",UVM_LOW)
start_item(req);
assert(req.randomize() with {
                            hwrite==1;
							hsize==3'b000;
													    hburst==3'b111;//INCR16 
							});
`uvm_info(get_type_name(),$sformatf("SEQ:hwdata=%p haddr=0x%0h hsize=%0b hburst=%0b hwrite=%0b",req.hwdata, req.haddr, req.hsize, req.hburst, req.hwrite),UVM_LOW)
finish_item(req);
`uvm_info(get_type_name(),"write sequence has ended",UVM_LOW)
end

begin
`uvm_info(get_type_name(),"read sequence has started",UVM_LOW)
start_item(req);
assert(req.randomize() with {
                            hwrite==0;
							hsize==3'b000;
													    hburst==3'b111;//INCR16 
							});
`uvm_info(get_type_name(),$sformatf("SEQ:hwdata=%p haddr=0x%0h hsize=%0b hburst=%0b hwrite=%0b",req.hwdata, req.haddr, req.hsize, req.hburst, req.hwrite),UVM_LOW)
finish_item(req);
`uvm_info(get_type_name(),"read sequence has ended",UVM_LOW)
end

endtask
endclass



