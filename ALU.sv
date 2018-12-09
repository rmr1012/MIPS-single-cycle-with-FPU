module ALU (a,b,op,c,zero);
	input [31:0] a;
	input [31:0] b;
	input [2:0] op;
	output logic [31:0] c;
	output logic zero;



always_comb begin

	case(op)
	3'b010: c = a + b;
	3'b110: c = a + (~b + 1'b1);
	3'b000: c = {1'bx,(a&b)};  //a&b
	3'b001: c = {1'bx,(a|b)};  //a|b
	3'b111: c = (a<b) ? 1 : 0;  //a^b
	default: c = 0; // shit case

	endcase
	zero = (c == 0) ? 1 : 0; // if output is 0, set zero to 1
end
endmodule
