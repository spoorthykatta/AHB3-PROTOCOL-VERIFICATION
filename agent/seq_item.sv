class seq_item extends uvm_sequence_item;
`uvm_object_utils(seq_item)

rand bit [31:0] hwdata[$];//to get different data for each transferand bit [31:0] hwdata[16];
//rand bit [31:0] hwdata[16];
rand bit [31:0] haddr;
rand bit [2:0] hsize;
rand bit [2:0] hburst;
rand bit hsel; 
rand bit hwrite;
rand bit [1:0] htrans;

bit [1:0] hresp;
bit hready;
bit [31:0] hrdata[$];
rand int no_of_beats;
int i;

function new(string name="seq_item");
super.new(name);
endfunction

//-------BEAT SIZE-------
function int beat_size();
case(hsize)
3'b000: return 1;//byte
3'b001: return 2;//halfword
3'b010: return 4;//word
default: return 1;
endcase
endfunction

constraint c_hburst {
    (hburst == 3'b000) -> (no_of_beats == 1);//SINGLE BURST

    (hburst == 3'b001) -> (no_of_beats == 10);//UNDEFINED INCR(limited to 10 transfers)

    (hburst inside {3'b010, 3'b011}) -> (no_of_beats == 4);//WRAP4, INCR4

    (hburst inside {3'b100, 3'b101}) -> (no_of_beats == 8);//WRAP8, INCR8

    (hburst inside {3'b110, 3'b111}) -> (no_of_beats == 16);//WRAP16, INCR16
    }

constraint narrow_transfers {
    foreach (hwdata[i])
	{
    if (hsize == 3'b000)
	hwdata[i][31:8] == 0;

	else if (hsize == 3'b010)
	hwdata[i][31:16] == 0;
	}
	}

//if wdata is taken as queue use this constraint
constraint wdata {
  hwdata.size() == no_of_beats;
}

constraint addr_alignment {
   //(hburst inside {3'b011, 3'b101, 3'b111}) -> haddr % (no_of_beats * beat_size()) == 0;//WRAP4, WRAP8,WRAP16
    
    //(hburst inside {3'b000, 3'b001, 3'b010, 3'b100, 3'b110}) -> haddr % beat_size() == 0;
    haddr % beat_size() == 0;
    }
//In AHB, address must be aligned to the transfer size. So I constrain haddr to be a multiple of beat_size(). This ensures the lower bits of the address are zero according to HSIZE, preventing unaligned transfers.

constraint c_addr_1kb_boundary {
    haddr < 256;
    if (hburst != 3'b000) 
//	{(haddr[9:0] + (no_of_beats * beat_size())-1) < 1024;}
    {((haddr % 1024) + (no_of_beats * beat_size())) <=1024;}
	}
//In AHB, a burst transfer must not cross a 1KB address boundary. That means the start address and the last address of the burst must lie within the same 1KB memory region.
//Since 1KB equals 1024 bytes, which is 2^10, the lower 10 bits of the address represent the offset within a 1KB block. So I use haddr[9:0] to check whether the burst stays within that block.
/*haddr[9:0] gives the offset inside the 1KB region.
no_of_beats * beat_size() gives the total number of bytes in the burst.
Adding them gives the end address offset.
I subtract 1 because I need to check the last byte address, not the next address.
If the final offset is less than 1024, then the entire burst remains inside the same 1KB region.*/


endclass

