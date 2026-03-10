package packk;

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "../agent/seq_item.sv"

`include "../sequence/sequence.sv"
`include "../sequence/seq_single_burst_1byte.sv"
`include "../sequence/seq_single_burst_2bytes.sv"
`include "../sequence/seq_single_burst_4bytes.sv"
`include "../sequence/seq_undef_incr_1byte.sv"
`include "../sequence/seq_undef_incr_2bytes.sv"
`include "../sequence/seq_undef_incr_4bytes.sv"
`include "../sequence/seq_incr4_1byte.sv"
`include "../sequence/seq_incr4_2bytes.sv"
`include "../sequence/seq_incr4_4bytes.sv"
`include "../sequence/seq_incr8_1byte.sv"
`include "../sequence/seq_incr8_2bytes.sv"
`include "../sequence/seq_incr8_4bytes.sv"
`include "../sequence/seq_incr16_1byte.sv"
`include "../sequence/seq_incr16_2bytes.sv"
`include "../sequence/seq_incr16_4bytes.sv"
`include "../sequence/seq_wrap4_1byte.sv"
`include "../sequence/seq_wrap4_2bytes.sv"
`include "../sequence/seq_wrap4_4bytes.sv"
`include "../sequence/seq_wrap8_1byte.sv"
`include "../sequence/seq_wrap8_2bytes.sv"
`include "../sequence/seq_wrap8_4bytes.sv"
`include "../sequence/seq_wrap16_1byte.sv"
`include "../sequence/seq_wrap16_2bytes.sv"
`include "../sequence/seq_wrap16_4bytes.sv"




`include "../agent/sequencer.sv"
`include "../agent/driver.sv"
`include "../agent/monitor.sv"
`include "../agent/agent.sv"

`include "../env/scoreboard.sv"
`include "../env/subscriber.sv"
`include "../env/environment.sv"

`include "../test/test.sv"
`include "../test/test_single_burst_1byte.sv"
`include "../test/test_single_burst_2bytes.sv"
`include "../test/test_single_burst_4bytes.sv"
`include "../test/test_undef_incr_1byte.sv"
`include "../test/test_undef_incr_2bytes.sv"
`include "../test/test_undef_incr_4bytes.sv"
`include "../test/test_incr4_1byte.sv"
`include "../test/test_incr4_2bytes.sv"
`include "../test/test_incr4_4bytes.sv"
`include "../test/test_incr8_1byte.sv"
`include "../test/test_incr8_2bytes.sv"
`include "../test/test_incr8_4bytes.sv"
`include "../test/test_incr16_1byte.sv"
`include "../test/test_incr16_2bytes.sv"
`include "../test/test_incr16_4bytes.sv"
`include "../test/test_wrap4_1byte.sv"
`include "../test/test_wrap4_2bytes.sv"
`include "../test/test_wrap4_4bytes.sv"
`include "../test/test_wrap8_1byte.sv"
`include "../test/test_wrap8_2bytes.sv"
`include "../test/test_wrap8_4bytes.sv"
`include "../test/test_wrap16_1byte.sv"
`include "../test/test_wrap16_2bytes.sv"
`include "../test/test_wrap16_4bytes.sv"



endpackage


