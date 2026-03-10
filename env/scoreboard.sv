class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)

uvm_analysis_imp#(seq_item,scoreboard)sb_imp;
reg [31:0] ref_mem [0:255];//reference model memory
seq_item queue[$];
seq_item tr;

function new(string name,uvm_component parent);
super.new(name,parent);
sb_imp=new("sb_imp",this);
endfunction

virtual function void write(seq_item tr);
queue.push_back(tr);
endfunction

task run_phase(uvm_phase phase);
forever begin
wait(queue.size()>0);
tr=queue.pop_front();

if(tr.pslverr)
`uvm_info(get_type_name(),"INVALID ADDRESS",UVM_LOW)

else begin
//write tx 
if(tr.pwrite)begin
ref_mem[tr.paddr]=tr.pwdata;
`uvm_info(get_type_name(),$sformatf("SB write: paddr=0x%0h pwdata=0x%0h",tr.paddr, tr.pwdata),UVM_LOW)
end

//read tx 
else begin
//bit [31:0] exp_data;
if(tr.prdata!==ref_mem[tr.paddr])begin
	$display("----------------------------------------------------------------------------------------------------------------------------");
	$display("-------------------------------------------------TEST FAILED-----------------------------------------------------------------");
	$display("----------------------------------------------------------------------------------------------------------------------------");
`uvm_error(get_type_name(),$sformatf("DATA MISMATCH addr=0x%0h exp=0x%0h act=0x%0h",tr.paddr, ref_mem[tr.paddr], tr.prdata))
end
else begin
	$display("----------------------------------------------------------------------------------------------------------------------------");
	$display("-------------------------------------------------TEST PASSED-----------------------------------------------------------------");
	$display("----------------------------------------------------------------------------------------------------------------------------");

`uvm_info(get_type_name(),$sformatf("DATA MATCH paddr=0x%0h exp=0x0h act=0x0h",tr.paddr, ref_mem[tr.paddr], tr.prdata),UVM_LOW)
end
end
end
end
endtask
endclass



