class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)

uvm_analysis_imp#(seq_item,scoreboard)sb_imp;
seq_item tr;
reg [31:0] ref_mem [0:255];//reference memory
seq_item queue[$];
int i;

function new(string name,uvm_component parent);
super.new(name,parent);
sb_imp=new("sb_imp",this);
endfunction

virtual function void write(seq_item tr);
queue.push_back(tr);
endfunction

task run_phase(uvm_phase phase);
super.run_phase(phase);

forever begin

wait(queue.size()>0)begin
tr=queue.pop_front();
end

if(tr.hresp)begin
`uvm_info(get_type_name(),"RESPONSE ERROR",UVM_LOW)
continue;
end

else begin
//write tx
ref_mem[tr.haddr]=tr.hwdata[i];
`uvm_info(get_type_name(),$sformatf("SB WRITE: haddr=0x%0h hwdata=0x%0h",tr.haddr, tr.hwdata),UVM_LOW)
end

//read tx
//else begin
if(tr.hrdata[i]!==ref_mem[tr.haddr])begin
$display("-------------------------------------------------");
$display("--------------------TEST FAILED-------------------");
$display("-------------------------------------------------");
end
else begin
$display("-------------------------------------------------");
$display("--------------------TEST PASSED-------------------");
$display("-------------------------------------------------");
end
//end
end
endtask


endclass

