
module MIPS_tb();

reg rst,clk,y;

MIPS_12 uut (
	.rst(rst),
	.clk(clk),
	.y(y)
);
initial begin
	clk=0;
	rst=1;
	#25
	rst=0;
end

always begin
	#10
	clk=!clk;
end

endmodule
