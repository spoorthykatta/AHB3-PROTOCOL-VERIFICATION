.ONESHELL:

PKG=../top/package.sv
TB=../top/top.sv
RTL=../rtl/apb_slave.sv
INTF=../interface/interface.sv

DIR=+incdir+../agent +incdir+../sequence +incdir+../env +incdir+../test

IRUN=irun -sv -uvm -sva -access +rwc -ALLOWREDEFINITION -coverage all -covoverwrite -covworkdir reg_cov

TC1=test_rw
TC2=test_wo
TC3=test_ro
TC4=test_we
TC5=test_re

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

test_rw:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC1) -covtest $(TC1) -l ./testlogs/$(TC1).log
test_wo:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC2) -covtest $(TC2) -l ./testlogs/$(TC2).log

test_ro:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC3) -covtest $(TC3) -l ./testlogs/$(TC3).log

test_we:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC4) -covtest $(TC4) -l ./testlogs/$(TC4).log

test_re:
	$(IRUN) $(RTL) $(INTF) $(PKG) $(TB) $(DIR) $(SEED) random -timescale 1ns/1ps +UVM_TESTNAME=$(TC5) -covtest $(TC5) -l ./testlogs/$(TC5).log
	
regress:
	make test_rw test_wo test_ro test_we test_re

cov:
	imc &

