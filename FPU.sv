
module fp_12(
	input op,  // op-code :0 is add, 1 is subtract
	input [31:0] a, b,
	output logic [31:0] c);

	logic sign_a;
	logic sign_b;
	logic sign_c;

	logic sign_1, sign_2;

	logic [7:0] exponent_a,exponent_b,exponent_diff;
	logic [7:0] exponent_c;
	logic [25:0] mantissa_of,mantissa_of_ctrl , mantissa_of_flip;
	logic [24:0] mantissa_a, mantissa_b , opranda, oprandb;
	logic [22:0] mantissa_c;
	logic dominance; // 0 = a, 1=b
	logic of,of1;
	logic [5:0] encoderShift;
	logic [3:0] thetype;
	logic comp; // 0: +1 , 1:-1
	// not putting in sign bit yet to avoid shifting errors



	priority_enc myenc(.in(mantissa_of_flip),  .out(encoderShift));

//	rippe_adder adder(.X(opranda) , .Y(oprandb) , .S(mantissa_of) , .Co(of));
	always_comb begin

	sign_a = a[31];
	sign_b = b[31];
	exponent_a = a[30:23];
	exponent_b = b[30:23];
	mantissa_a = {2'b01, a[22:0]};
	mantissa_b = {2'b01, b[22:0]};

// dominance,howmuch=expComp(a_exp,b_exp) # dominance True -> a False -> b
// a_mant_s, b_mant_s = shiftMant(dominance,howmuch,a_mant,b_mant)

	if(exponent_a > exponent_b) begin
		dominance=1'b0;
		exponent_c = exponent_a;
		exponent_diff = exponent_a - exponent_b;
		// if (largeGuy):
		// 			print("shifting b right by ",bits)
		mantissa_b = mantissa_b >> exponent_diff;
	end else if (exponent_a == exponent_b) begin
		dominance = (mantissa_a > mantissa_b) ? 0:1;
		exponent_c = exponent_b;
		exponent_diff=0;
	end else if (exponent_a < exponent_b) begin
		dominance=1'b1;
		exponent_c = exponent_b;
		exponent_diff = exponent_b - exponent_a;

		mantissa_a = mantissa_a >> exponent_diff;
	end

	sign_1 = sign_a;
	sign_2 = (~sign_b) ^ ~op;

	thetype={sign_1,sign_2,dominance};
	case ({sign_1,sign_2,dominance})
		3'b000: begin  mantissa_of= mantissa_a 		+ mantissa_b; sign_c=0;  end
		3'b001: begin  mantissa_of= mantissa_a 		+ mantissa_b; sign_c=0; end

		3'b010: begin  mantissa_of= mantissa_a 		+ ~mantissa_b+1; sign_c=0; end
		3'b011: begin  mantissa_of= mantissa_a 		+ ~mantissa_b+1; sign_c=1; end

		3'b100: begin  mantissa_of= ~mantissa_a+1	+	mantissa_b; 	sign_c=1; end
		3'b101: begin  mantissa_of= ~mantissa_a+1	+	mantissa_b; 	sign_c=0; end

		3'b110: begin  mantissa_of= ~(mantissa_a		+	mantissa_b)+1; sign_c=1; end
		3'b111: begin  mantissa_of= ~(mantissa_a		+	mantissa_b)+1; sign_c=1; end

		default: begin mantissa_of= mantissa_a 		+	mantissa_b; end
	endcase
	//c_sign,overflow , c_mant=mantALU(a_mant_s,b_mant_s, not int(a_sign) ,
	//int(b_sign)^addSign, a_sign, b_sign,dominance)

	//sign_c = mantissa_of[24] | mantissa_of[25];

		of = mantissa_of[25] ^ sign_c;

		if (sign_c) begin // if negative
        mantissa_of_flip = ~(mantissa_of)+1 ;
        $display("negating result");
		end
		else begin
				mantissa_of_flip = mantissa_of;

		end
		of1 = mantissa_of_flip[25] ^ sign_c;

		// grab encoder shift

		//c_exp_s=bin(int(c_exp,2)-bits+overflow)[2:].zfill(8) #
		exponent_c = exponent_c - encoderShift+1;
		// print("shifting c_mant left by ",bits,"bits")
		// c_mant_s=c_mant[bits:]+(bits*str((1-int(c_sign)) and int(exp_t)) )
		// return c_mant_s
		//mantissa_c = {mantissa_of[22:encoderShift], {encoderShift{~sign_c}} };
		if (encoderShift > 0) begin
			mantissa_c = ((mantissa_of_flip[22:0]) << encoderShift-1);
		end else begin
			mantissa_c = (mantissa_of_flip[23:1]) + 1;
		end
		c = {sign_c , exponent_c , mantissa_c};

end


endmodule


module priority_enc (
    input wire [24:0] in,
    output logic [4:0] out
  );
logic [4:0] temp;
assign temp = (in[24] == 1'b1) ? 'd24:
(in[23] == 1'b1) ? 'd23:
(in[22] == 1'b1) ? 'd22:
(in[21] == 1'b1) ? 'd21:
(in[20] == 1'b1) ? 'd20:
(in[19] == 1'b1) ? 'd19:
(in[18] == 1'b1) ? 'd18:
(in[17] == 1'b1) ? 'd17:
(in[16] == 1'b1) ? 'd16:
(in[15] == 1'b1) ? 'd15:
(in[14] == 1'b1) ? 'd14:
(in[13] == 1'b1) ? 'd13:
(in[12] == 1'b1) ? 'd12:
(in[11] == 1'b1) ? 'd11:
(in[10] == 1'b1) ? 'd10:
(in[9] == 1'b1) ? 'd9:
(in[8] == 1'b1) ? 'd8:
(in[7] == 1'b1) ? 'd7:
(in[6] == 1'b1) ? 'd6:
(in[5] == 1'b1) ? 'd5:
(in[4] == 1'b1) ? 'd4:
(in[3] == 1'b1) ? 'd3:
(in[2] == 1'b1) ? 'd2:
(in[1] == 1'b1) ? 'd1: 'd0;

assign out = 24-temp;
endmodule



module fulladder(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire w1,w2,w3;
  //Structural code for one bit full adder
  xor G1(w1, X, Y);
  xor G2(S, w1, Ci);
  and G3(w2, w1, Ci);
  and G4(w3, X, Y);
  or G5(Co, w2, w3);
endmodule


module rippe_adder(X, Y, S, Co);
 input [23:0] X, Y;// Two 4-bit inputs
 output [23:0] S;
 output Co;
 wire w1, w2, w3, w4, w5 ,w6, w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23;
 // instantiating 4 1-bit full adders in Verilog
 fulladder u1(X[0], Y[0], 1'b0, S[0], w1);
 fulladder u2(X[1], Y[1], w1, S[1], w2);
 fulladder u3(X[2], Y[2], w2, S[2], w3);
 fulladder u4(X[3], Y[3], w3, S[3], w4);
 fulladder u5(X[4], Y[4], w4, S[4], w5);
 fulladder u6(X[5], Y[5], w5, S[5], w6);
 fulladder u7(X[6], Y[6], w6, S[6], w7);
 fulladder u8(X[7], Y[7], w7, S[7], w8);
 fulladder u9(X[8], Y[8], w8, S[8], w9);
 fulladder u10(X[9], Y[9], w9, S[9], w10);
 fulladder u11(X[10], Y[10], w10, S[10], w11);
 fulladder u12(X[11], Y[11], w11, S[11], w12);
 fulladder u13(X[12], Y[12], w12, S[12], w13);
 fulladder u14(X[13], Y[13], w13, S[13], w14);
 fulladder u15(X[14], Y[14], w14, S[14], w15);
 fulladder u16(X[15], Y[15], w15, S[15], w16);
 fulladder u17(X[16], Y[16], w16, S[16], w17);
 fulladder u18(X[17], Y[17], w17, S[17], w18);
 fulladder u19(X[18], Y[18], w18, S[18], w19);
 fulladder u20(X[19], Y[19], w19, S[19], w20);
 fulladder u21(X[20], Y[20], w20, S[20], w21);
 fulladder u22(X[21], Y[21], w21, S[21], w22);
 fulladder u23(X[22], Y[22], w22, S[22], w23);
 fulladder u24(X[23], Y[23], w23, S[23], Co);

endmodule
