`include "uvm_macros.svh"
import uvm_pkg::*;
import packk::*;

module tb;

//declare global signals
bit hclk;
bit hresetn;

//clock generation
initial begin
hclk=0;
forever #5 hclk=~hclk;
end

//reset generation
initial begin
hresetn=0;
#1;
hresetn=1;
end

//interface instance
ahb_if vif(hclk,hresetn);

//dut instance
ahb_slave dut(
          .clk(vif.hclk),
		  .hresetn(vif.hresetn),
		  .haddr(vif.haddr),
		  .hwdata(vif.hwdata),
		  .hwrite(vif.hwrite),
		  .hsel(vif.hsel),
		  .hburst(vif.hburst),
		  .hsize(vif.hsize),
		  .htrans(vif.htrans),
		  .hresp(vif.hresp),
		  .hready(vif.hready),
		  .hrdata(vif.hrdata)
);

//dump file
initial begin
$dumpfile("dump.vcd");
$dumpvars();
end

initial begin
//config db set
uvm_config_db#(virtual ahb_if)::set(null,"*","vif",vif);
end 

initial begin
run_test("test");
end
endmodule

