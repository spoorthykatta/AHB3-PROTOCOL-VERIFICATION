class driver extends uvm_driver#(seq_item);
`uvm_component_utils(driver)

virtual apb_if vif;
seq_item req;

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
`uvm_fatal(get_type_name(),"virtual interface not set for driver")
else
`uvm_info(get_type_name(),"driver build_phase completed",UVM_LOW)
endfunction


virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
`uvm_info(get_type_name(),"driver transaction started",UVM_LOW)
reset_bus();//calling reset task
@(vif.drv_cb);

forever begin
seq_item_port.get_next_item(req);
drive(req);
seq_item_port.item_done(req);
`uvm_info(get_type_name(),"driver run_phase completed",UVM_LOW)
end
endtask

task reset_bus();

vif.paddr=0;
vif.pwrite=0;
vif.pwdata=0;
vif.psel=0;
vif.pen=0;
endtask

task drive(seq_item req);

if(req.pwrite==1)begin
driver_write(req);
end
 else begin
 driver_read(req);
 end
 endtask

 task driver_write(seq_item req);

 //------setup phase------

@(vif.drv_cb);

vif.drv_cb.paddr<=req.paddr;
//vif.drv_cb.pwdata<=req.pwdata;
vif.drv_cb.pwrite<=req.pwrite;
vif.drv_cb.psel<=1'b1;
vif.drv_cb.pen<=1'b0;

//------access phase------

@(vif.drv_cb);
vif.drv_cb.pen<=1'b1;

//-----wait for pready from dut------
wait(vif.drv_cb.pready);
vif.drv_cb.pwdata<=req.pwdata;
`uvm_info(get_type_name(),$sformatf("write transaction completed: pwdata=0x%0h pslverr=%0b",vif.drv_cb.pwdata, vif.drv_cb.pslverr),UVM_LOW)

@(vif.drv_cb);
endtask

task driver_read(seq_item req);

//------setup phase------

@(vif.drv_cb);

vif.drv_cb.paddr<=req.paddr;
vif.drv_cb.pwdata<=0;
vif.drv_cb.pwrite<=req.pwrite;
vif.drv_cb.psel<=1'b1;
vif.drv_cb.pen<=1'b0;

//------access phase------

@(vif.drv_cb);
vif.drv_cb.pen<=1'b1;

//-----wait for pready from dut------
wait(vif.drv_cb.pready);
req.prdata=vif.drv_cb.prdata;
`uvm_info(get_type_name(),$sformatf("read transaction completed: prdata=0x%0h pslverr=%0b",req.prdata, vif.drv_cb.pslverr),UVM_LOW)

@(vif.drv_cb);
endtask

endclass
