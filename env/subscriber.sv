class subscriber extends uvm_subscriber#(seq_item);
`uvm_component_utils(subscriber)

seq_item t;

covergroup cg;
option.per_instance=1;

cp_htrans: coverpoint t.htrans {
bins NONSEQ={2'b00};
bins SEQ={2'b01};
}

cp_hwrite: coverpoint t.hwrite {
bins WRITE={1};
bins READ={0};
}

cp_hsize: coverpoint t.hsize {
bins BYTE={3'b000};
bins HALFWORD={3'b001};
bins WORD={3'b010};
}

cp_hburst: coverpoint t.hburst {
bins SINGLE={3'b000};
bins UNDEF_INCR={3'b001};
bins WRAP4={3'b010};
bins INCR4={3'b011};
bins WRAP8={3'b100};
bins INCR8={3'b101};
bins WRAP16={3'b110};
bins INCR16={3'b111};
}

cp_hresp: coverpoint t.hresp {
bins OKAY={0};
bins ERROR={1};
}

cp_haddr: coverpoint t.haddr {
bins LOW_={[0:63]};
bins MED={[64:127]};
bins HIGH_={[128:255]};
}

cross cp_hwrite, cp_hsize;
cross cp_hburst, cp_hsize;
cross cp_hwrite, cp_hburst;

endgroup

function new(string name,uvm_component parent);
super.new(name,parent);
cg=new();
endfunction

function void write(seq_item t);
this.t=t;
cg.sample();
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
t=seq_item::type_id::create("t",this);
endfunction

endclass





