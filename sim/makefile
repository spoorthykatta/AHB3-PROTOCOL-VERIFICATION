.ONESHELL:

PKG=../top/package.sv
TB=../top/top.sv
RTL=../rtl/ahb_rtl.sv
INTF=../interface/interface.sv

DIR=+incdir+../agent +incdir+../sequence +incdir+../env +incdir+../test

IRUN=irun -sv -uvm -sva -access +rwc -ALLOWREDEFINITION -coverage all -covoverwrite -covworkdir reg_cov

TC1=test
TC2=test_single_burst_1byte
TC3=test_single_burst_2bytes
TC4=test_single_burst_4bytes
TC5=test_undef_incr_1byte
TC6=test_undef_incr_2bytes
TC7=test_undef_incr_4bytes
TC8=test_incr4_1byte
TC9=test_incr4_2bytes
TC10=test_incr4_4bytes
TC11=test_incr8_1byte
TC12=test_incr8_2bytes
TC13=test_incr8_4bytes
TC14=test_incr16_1byte
TC15=test_incr16_2bytes
TC16=test_incr16_4bytes
TC17=test_wrap4_1byte
TC18=test_wrap4_2bytes
TC19=test_wrap4_4bytes
TC20=test_wrap8_1byte
TC21=test_wrap8_2bytes
TC22=test_wrap8_4bytes
TC23=test_wrap16_1byte
TC24=test_wrap16_2bytes
TC25=test_wrap16_4bytes

SEED=-svseed

clean:
	rm -rf INCA_libs cov_work *.txt dump* *.log *.history

run:
	@cat test_list.f
	@echo ""
	@echo "Please select any one testcase:"
	@read TESTCASE
	@echo ""
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME="$$TESTCASE" -covtest "$$TESTCASE" -l ./testlogs/"$$TESTCASE".log +UVM_VERBOSITY=UVM_LOW

sim:	
	simvision &

test:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC1) -covtest $(TC1) -l ./testlogs/$(TC1).log

test_single_burst_1byte:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC2) -covtest $(TC2) -l ./testlogs/$(TC2).log

test_single_burst_2bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC3) -covtest $(TC3) -l ./testlogs/$(TC3).log

test_single_burst_4bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC4) -covtest $(TC4) -l ./testlogs/$(TC4).log

test_undef_incr_1byte:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC5) -covtest $(TC5) -l ./testlogs/$(TC5).log

test_undef_incr_2bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC6) -covtest $(TC6) -l ./testlogs/$(TC6).log

test_undef_incr_4bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC7) -covtest $(TC7) -l ./testlogs/$(TC7).log

test_incr4_1byte:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC8) -covtest $(TC8) -l ./testlogs/$(TC8).log

test_incr4_2bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC9) -covtest $(TC9) -l ./testlogs/$(TC9).log

test_incr4_4bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC10) -covtest $(TC10) -l ./testlogs/$(TC10).log

test_incr8_1byte:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC11) -covtest $(TC11) -l ./testlogs/$(TC11).log

test_incr8_2bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC12) -covtest $(TC12) -l ./testlogs/$(TC12).log

test_incr8_4bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC13) -covtest $(TC13) -l ./testlogs/$(TC13).log

test_incr16_1byte:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC14) -covtest $(TC14) -l ./testlogs/$(TC14).log

test_incr16_2bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC15) -covtest $(TC15) -l ./testlogs/$(TC15).log

test_incr16_4bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC16) -covtest $(TC16) -l ./testlogs/$(TC16).log

test_wrap4_1byte:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC17) -covtest $(TC17) -l ./testlogs/$(TC17).log

test_wrap4_2bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC18) -covtest $(TC18) -l ./testlogs/$(TC18).log

test_wrap4_4bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC19) -covtest $(TC19) -l ./testlogs/$(TC19).log

test_wrap8_1byte:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC20) -covtest $(TC20) -l ./testlogs/$(TC20).log

test_wrap8_2bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC21) -covtest $(TC21) -l ./testlogs/$(TC21).log

test_wrap8_4bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC22) -covtest $(TC22) -l ./testlogs/$(TC22).log

test_wrap16_1byte:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC23) -covtest $(TC23) -l ./testlogs/$(TC23).log

test_wrap16_2bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC24) -covtest $(TC24) -l ./testlogs/$(TC24).log

test_wrap16_4bytes:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC25) -covtest $(TC25) -l ./testlogs/$(TC25).log


regress:
	make test 
	make test_single_burst_1byte 
	make test_single_burst_2bytes 
	make test_single_burst_4bytes 
	make test_undef_incr_1byte 
	make test_undef_incr_2bytes 
	make test_undef_incr_4bytes 
	make test_incr8_1byte 
	make test_incr8_2bytes 
	make test_incr8_4bytes 
	make test_incr16_1byte 
	make test_incr16_2bytes 
	make test_incr16_4bytes 
	make test_wrap4_1byte 
	make test_wrap4_2bytes 
	make test_wrap4_4bytes 
	make test_wrap8_1byte 
	make test_wrap8_2bytes 
	make test_wrap8_4bytes 
	make test_wrap16_1byte 
	make test_wrap16_2bytes 
	make test_wrap16_4bytes

cov:
	imc &


