package packk;

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "../agent/seq_item.sv"

`include "../sequence/sequence_rw.sv"
`include "../sequence/sequence_wo.sv"
`include "../sequence/sequence_ro.sv"
`include "../sequence/sequence_we.sv"
`include "../sequence/sequence_re.sv"

`include "../agent/sequencer.sv"
`include "../agent/driver.sv"
`include "../agent/monitor.sv"
`include "../agent/agent.sv"

`include "../env/scoreboard.sv"
`include "../env/subscriber.sv"
`include "../env/environment.sv"

`include "../test/test_rw.sv"
`include "../test/test_wo.sv"
`include "../test/test_ro.sv"
`include "../test/test_we.sv"
`include "../test/test_re.sv"

endpackage

