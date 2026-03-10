class subscriber extends uvm_subscriber#(seq_item);
`uvm_component_utils(subscriber)
seq_item t;

//-------covergroup---------

covergroup cg;
option.per_instance=1;

coverpoint t.pwrite{
bins READ={0};
bins WRITE={1};
}

coverpoint t.paddr{
bins VALID_ADDR={[0:255]};
bins INVALID_ADDR={[256:$]};
}

coverpoint t.pslverr{
bins ERR={1};
bins NO_ERR={0};
}

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
