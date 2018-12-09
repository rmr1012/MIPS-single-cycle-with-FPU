

module DataMemory(input [5:0] address,
	input [31:0] data_in,
	input clk,
	input memRead,memWrite, // 1 is read 0 is write
	output logic [31:0] data_out);

logic [8-1:0] dmem [0:2**6-1]; //** is the power operator// 8 bit wide, 2^6=64 byte long

parameter dmem_INIT = "//Mac/Home/Documents/MIPS-single-cycle/mips1_data.txt";

initial begin
	$readmemh(dmem_INIT, dmem);
end

always @ (posedge clk)  begin // suspecious

	if(memWrite) begin
		{dmem[address],dmem[address+1],dmem[address+2],dmem[address+3]} <= data_in;
	end
end

assign data_out = memRead ? {dmem[address],dmem[address+1],dmem[address+2],dmem[address+3]}:0;


endmodule
