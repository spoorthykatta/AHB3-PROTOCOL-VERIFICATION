class sequencee extends uvm_sequence#(seq_item);
`uvm_object_utils(sequencee)

seq_item req;
bit [31:0] queue[$];

function new(string name="sequencee");
super.new(name);
endfunction

task body();

begin
req=seq_item::type_id::create("req");

`uvm_info(get_type_name(),"write sequence has started",UVM_LOW)
start_item(req);
assert(req.randomize() with {
              hwrite==1;
							hsize==3'b010;
							hburst==3'b001;
							haddr==32'h18;
							});
`uvm_info(get_type_name(),$sformatf("SEQ:hwdata=%p haddr=0x%0h hsize=%0b hburst=%0b hwrite=%0b",req.hwdata, req.haddr, req.hsize, req.hburst, req.hwrite),UVM_LOW)
//foreach (req.hwdata[i]) begin
  //`uvm_info(get_type_name(),$sformatf("Beat[%0d] :: hwdata = 0x%0h", i, req.hwdata[i]),UVM_LOW)
//end
queue.push_back(req.haddr);

finish_item(req);
`uvm_info(get_type_name(),"write sequence has ended",UVM_LOW)
end

begin
req=seq_item::type_id::create("req");
`uvm_info(get_type_name(),"read sequence has started",UVM_LOW)
start_item(req);
req.haddr=queue.pop_front();

assert(req.randomize() with {
              hwrite==0;
							hsize==3'b010;
							hburst==3'b001;
							haddr==32'h18;
							});
							 `uvm_info(get_type_name(),$sformatf("haddr=0x%0h hsize=%0b hburst=%0b hwrite=%0b",req.haddr, req.hsize, req.hburst, req.hwrite),UVM_LOW)
//foreach (req.hwdata[i]) begin
  //`uvm_info(get_type_name(),$sformatf("Beat[%0d] :: hrdata = 0x%0h", i, req.hrdata[i]),UVM_LOW)
//end
finish_item(req);
`uvm_info(get_type_name(),"read sequence has ended",UVM_LOW)
end

endtask


endclass

