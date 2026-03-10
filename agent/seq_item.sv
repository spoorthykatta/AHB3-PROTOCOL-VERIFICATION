class seq_item extends uvm_sequence_item;

rand bit [31:0] paddr;
rand bit [31:0] pwdata;
rand bit pwrite;
rand bit psel;
rand bit pen;

bit [31:0]prdata;
bit pslverr;
bit pready;

`uvm_object_utils_begin(seq_item)
`uvm_field_int(paddr,UVM_ALL_ON)
`uvm_field_int(pwdata,UVM_ALL_ON)
`uvm_field_int(pwrite,UVM_ALL_ON)
`uvm_field_int(psel,UVM_ALL_ON)
`uvm_field_int(pen,UVM_ALL_ON)
`uvm_object_utils_end

function new(string name="seq_item");
super.new(name);
endfunction

endclass



