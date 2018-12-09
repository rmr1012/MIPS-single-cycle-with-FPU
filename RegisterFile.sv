
module RegisterFile (
	input clk,
	input rst,
	input  [4:0] rs, rt, wn,
	input  [31:0] wd,
	input  RegWrite,
	output logic [31:0] rd1, rd2
);

logic [32-1:0] file [32-1:0]; //** is the power operator// 8 bit wide, 2^6=64 byte long

parameter MEM_INIT = "//Mac/Home/Documents/MIPS-single-cycle/regfile.txt";

initial begin
	$readmemh(MEM_INIT, file);
end
always @(posedge rst) begin
	$readmemh(MEM_INIT, file);
end
always @(posedge clk) begin//write, on clock
	if (RegWrite) begin
		file[wn]<=wd;
	end
end

assign rd1=file[rs];
assign rd2=file[rt];


endmodule
