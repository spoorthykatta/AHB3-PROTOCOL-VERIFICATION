interface apb_if(input bit pclk, input bit prst);
//................
//  APB SIGNALS
//................
logic [31:0] paddr;
logic pwrite;
logic [31:0] pwdata;
logic psel;
logic pen;

//response signals
logic [31:0] prdata;
logic pready;
logic pslverr;

//.......................
// DRIVER CLOCKING BLOCK-when signals driven or sampled(timing control,synchronization))
//.......................
clocking drv_cb @(posedge pclk);
default output #0 input #1;

output paddr;
output pwrite;
output pwdata;
output psel;
output pen;

input prdata;
input pready;
input pslverr;
endclocking

//........................
// MONITOR CLOCKING BLOCK
//........................
clocking mon_cb @(posedge pclk);
default input #1 output#0;

input paddr;
input psel;
input pen;
input pwrite;
input pwdata;

input prdata;
input pready;
input pslverr;
endclocking

//...............
//   MODPORTS-define direction,role
//...............
modport driver(clocking drv_cb,input prst);

modport monitor(clocking mon_cb,input prst);

modport dut(input pclk,prst,
            input paddr,psel,pwrite,pwdata,pen,
            output prdata,pready,pslverr
);


//-----------------
//  ASSERTIONS
//----------------

//----IDLE STATE ASSERTION-----

property apb_idle;
@(posedge pclk)
prst |-> (psel==0 &&
          pen==0 &&
		  pready==0 &&
		  pslverr==0);
endproperty

assert property(apb_idle)
else $warning("APB RESET ERROR: Interface not idle during reset");

//-----SETUP STATE ASSERTION----

//---setup only 1 clk cycle next cycle access state

property apb_setup_to_access;
@(posedge pclk)
(psel && !pen) |=> (psel && pen);
endproperty

assert property(apb_setup_to_access)
 else $warning("APB SETUP ERROR: SETUP did not transition to ACCESS");

//---setup state corrections----

property apb_setup_correctness;
@(posedge pclk)
(psel && !pen) |-> (
                    psel==1'b1 &&
                    pen==1'b0 &&
					pready==1'b0 &&
					pslverr==1'b0 &&
					!$isunknown(paddr) &&
					!$isunknown(pwrite)
					);
endproperty

assert property(apb_setup_correctness)
else $warning("APB SETUP ERROR: Invalid signals during SETUP phase");

//-------ACCESS STATE ASSERTIONS-----

//----access state correctness---

property apb_access_correctness;
@(posedge pclk)
(psel && pen) |-> (psel==1'b1 && pen==1'b1);
endproperty

assert property(apb_access_correctness)
else $warning("APB ACCESS ERROR: Invalid signals during ACCESS phase");

//-----access after setup-----

property apb_access_follows_setup;
@(posedge pclk)
(psel && pen) |-> $past(psel && !pen);
endproperty

assert property(apb_access_follows_setup)
  else $warning("APB ACCESS ERROR: ACCESS phase did not follow SETUP");

//---pen must no assert without setup

property apb_pen_requires_setup;
@(posedge pclk)
pen |-> $past(psel && !pen);
endproperty

assert property(apb_pen_requires_setup)
else $warning("APB PROTOCOL ERROR: PENABLE asserted without SETUP phase");

//---SIGNAL STABILITY ASSERTIONS----

//----signal stability from setup to access

property apb_signal_stability;
@(posedge pclk)
(psel && !pen) |=> (
                  $stable(paddr) &&
                  $stable(pwdata) &&
				  $stable(pwrite) &&
				  $stable(psel)
				  );
endproperty

assert property(apb_signal_stability)
else $warning("APB ERROR: PADDR/PWRITE/PSEL/PEN changed between SETUP and ACCESS");

//-------pwdata stable for write transfers---

property apb_pwdata_stability;
@(posedge pclk)
(psel && !pen && pwrite) |=> ($stable(pwdata));
endproperty

assert property(apb_pwdata_stability)
else $warning("APB ERROR: PWDATA changed between SETUP and ACCESS");


endinterface
