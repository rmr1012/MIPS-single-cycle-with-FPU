

module tb_DM;

logic [5:0] address;
logic [31:0] data_in;
logic  memRead;
logic [31:0] data_out;

DataMemory uut (
.address(address),
.data_in(data_in),
.data_out(data_out),
.memRead(memRead)
); 

initial begin
//clk=1;
memRead=1;
#10
address=0;
#10
address=4;
#10
address=8;
#10
memRead=0;
data_in=32'h12345678;
address=0;
#10
data_in=32'h56565656;
address=4;
#10
data_in=32'hb8989898;
address=8;
#10
memRead=1;
address=0;
#10
address=4;
#10
address=8;

end

//always begin 
	//#5
	//clk=!clk;
//end
endmodule