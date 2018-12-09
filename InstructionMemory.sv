
module InstructionMemory(input [5:0] PC,
	input rst,
	output logic [31:0] instruction,
	output logic halt);

logic [8-1:0] imem [0:2**6-1]; //** is the power operator// 8 bit wide, 2^6=64 byte long

parameter imem_INIT = "//Mac/Home/Documents/MIPS-single-cycle/mips1.txt";

initial begin
	$readmemh(imem_INIT, imem);
end


always_comb  begin
	instruction = {imem[PC],imem[PC+1],imem[PC+2],imem[PC+3]};
	halt = rst ? 0 : (({imem[PC],imem[PC+1],imem[PC+2],imem[PC+3]}==0 || {imem[PC],imem[PC+1],imem[PC+2],imem[PC+3]}=== 32'bX) ? 1:0) ;
end


endmodule
