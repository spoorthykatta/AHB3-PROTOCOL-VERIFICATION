`include "uvm_macros.svh"
import uvm_pkg::*;
import packk::*;

module tb_top;

//declare global variables
bit pclk;
bit prst;

//clock generation
initial begin
	pclk=0;
	forever #5 pclk=~pclk;
end

//reset generation
initial begin
	prst=1;
	#15;
	prst=0;
end

//interface instance
apb_if vif(pclk,prst);

//dut instance
apb_design_n dut(
	.pclk(vif.pclk),
	.prst(vif.prst),
	.paddr(vif.paddr),
	.pwdata(vif.pwdata),
	.pwrite(vif.pwrite),
	.psel(vif.psel),
	.pen(vif.pen),
	.pready(vif.pready),
	.prdata(vif.prdata),
	.pslverr(vif.pslverr)
);

initial begin
	$dumpfile("dump.vcd");
	$dumpvars();
end
//config db
initial begin
uvm_config_db#(virtual apb_if)::set(null,"*","vif",vif);

//start test
run_test();
end
endmodule


