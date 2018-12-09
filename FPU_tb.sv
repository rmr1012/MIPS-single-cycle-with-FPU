
module FPU_tb;

	logic			[31:0] a, b;
	logic				op;
	logic			[31:0]	c;
	logic clk;
	logic rst;

	fp_12 uut(
		.a(a), .b(b),
		.op(op),
		.c(c)
	);
    reg correct;
    logic [31:0] ans;
    assign correct = (c == ans);

	initial begin
op=0;
a=32'b01000000101110000000010010011101; // 5.75056
b=32'b11000001100110111101111000110000; // -19.4835
ans=32'b11000001010110111011101000010010; // -13.7329
#50;
//------------------ new PFU op ------------------
//01000000101110000000010010011101 11000001100110111101111000110000
//0 10000001 101110000000010010011101
//1 10000011 100110111101111000110000
//b exp is bigger by  2
//shifting a right by  2
//0 10000001 001011100000000100100111
//1 10000011 100110111101111000110000
//adding shifted mant
//sign1 + sign2 +
//raw result	 110010011101111101010111
//0 False True
//C no Supp:	 110010011101111101010111
//result mant 	 110010011101111101010111
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//0 10000011 110010011101111101010111
//


op=0;
a=32'b00111110110110010101101011011110; // 0.424521
b=32'b11000010010110111110110101010001; // -54.9818
ans=32'b11000010010110100011101010011011; // -54.5572
#50;
//------------------ new PFU op ------------------
//00111110110110010101101011011110 11000010010110111110110101010001
//0 01111101 110110010101101011011110
//1 10000100 110110111110110101010001
//b exp is bigger by  7
//shifting a right by  7
//0 01111101 000000011011001010110101
//1 10000100 110110111110110101010001
//adding shifted mant
//sign1 + sign2 +
//raw result	 110111011010000000000110
//0 False True
//C no Supp:	 110111011010000000000110
//result mant 	 110111011010000000000110
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//0 10000100 110111011010000000000110
//


op=1;
a=32'b11000001011001101100111110010000; // -14.4257
b=32'b11000011000100111111110100011010; // -147.989
ans=32'b01000011000001011001000000100001; // 133.563
#50;
//------------------ new PFU op ------------------
//11000001011001101100111110010000 11000011000100111111110100011010
//1 10000010 111001101100111110010000
//1 10000110 100100111111110100011010
//b exp is bigger by  4
//shifting a right by  4
//1 10000010 000011100110110011111001
//1 10000110 100100111111110100011010
//adding shifted mant
//sign1 - sign2 -
//raw result	 010111011001010111101011
//1 True True
//Underflow detected, going to negative
//C no Supp:	 010111011001010111101100
//result mant 	 010111011001010111101100
//need to normalize by  1  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  1 bits
//0 10000101 101110110010101111011001
//


op=0;
a=32'b01000000001000110010000010001111; // 2.54886
b=32'b10111101110101101010100000000100; // -0.104813
ans=32'b01000000000111000110101101001111; // 2.44405
#50;
//------------------ new PFU op ------------------
//01000000001000110010000010001111 10111101110101101010100000000100
//0 10000000 101000110010000010001111
//1 01111011 110101101010100000000100
//a exp is bigger by  5
//shifting b right by  5
//0 10000000 101000110010000010001111
//1 01111011 000001101011010101000000
//adding shifted mant
//sign1 + sign2 +
//raw result	 101010011101010111001111
//0 False True
//C no Supp:	 101010011101010111001111
//result mant 	 101010011101010111001111
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//0 10000000 101010011101010111001111
//


op=1;
a=32'b11000010110101101111001100100110; // -107.475
b=32'b01000000011001011010110001011110; // 3.58865
ans=32'b11000010110111100010000010001001; // -111.064
#50;
//------------------ new PFU op ------------------
//11000010110101101111001100100110 01000000011001011010110001011110
//1 10000101 110101101111001100100110
//0 10000000 111001011010110001011110
//a exp is bigger by  5
//shifting b right by  5
//1 10000101 110101101111001100100110
//0 10000000 000001110010110101100010
//adding shifted mant
//sign1 - sign2 +
//signs disagree, choosing dominance sign
//raw result	 001100000011101000111011
//0 True False
//negating result
//C no Supp:	 110011111100010111000100
//result mant 	 110011111100010111000100
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//1 10000101 110011111100010111000100
//


op=1;
a=32'b00111111001000010110111110000110; // 0.630608
b=32'b11000010000100011101100000100100; // -36.4611
ans=32'b01000010000101000101110111100010; // 37.0917
#50;
//------------------ new PFU op ------------------
//00111111001000010110111110000110 11000010000100011101100000100100
//0 01111110 101000010110111110000110
//1 10000100 100100011101100000100100
//b exp is bigger by  6
//shifting a right by  6
//0 01111110 000000101000010110111110
//1 10000100 100100011101100000100100
//adding shifted mant
//sign1 + sign2 -
//signs disagree, choosing dominance sign
//raw result	 011100001010110110011001
//0 True False
//negating result
//C no Supp:	 100011110101001001100110
//result mant 	 100011110101001001100110
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//1 10000100 100011110101001001100110
//


op=1;
a=32'b10111111000011111010010011000111; // -0.561108
b=32'b01000010111101011111001111001011; // 122.976
ans=32'b11000010111101110001001100010101; // -123.537
#50;
//------------------ new PFU op ------------------
//10111111000011111010010011000111 01000010111101011111001111001011
//1 01111110 100011111010010011000111
//0 10000101 111101011111001111001011
//b exp is bigger by  7
//shifting a right by  7
//1 01111110 000000010001111101001001
//0 10000101 111101011111001111001011
//adding shifted mant
//sign1 - sign2 +
//signs disagree, choosing dominance sign
//raw result	 111101001101010010000001
//1 False False
//Overflow detected not agree
//C no Supp:	 111101001101010010000001
//result mant 	 111101001101010010000001
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//0 10000101 111101001101010010000001
//


op=1;
a=32'b00111010000100001001111111010011; // 0.000551698
b=32'b11000001111101101000111100000000; // -30.8198
ans=32'b01000001111101101001000000100001; // 30.8204
#50;
//------------------ new PFU op ------------------
//00111010000100001001111111010011 11000001111101101000111100000000
//0 01110100 100100001001111111010011
//1 10000011 111101101000111100000000
//b exp is bigger by  15
//shifting a right by  15
//0 01110100 000000000000000100100001
//1 10000011 111101101000111100000000
//adding shifted mant
//sign1 + sign2 -
//signs disagree, choosing dominance sign
//raw result	 000010010111001000100000
//0 True False
//negating result
//C no Supp:	 111101101000110111011111
//result mant 	 111101101000110111011111
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//1 10000011 111101101000110111011111
//


op=0;
a=32'b01000010001001111100000101000111; // 41.9387
b=32'b00111101101001101101000010000001; // 0.0814524
ans=32'b01000010001010000001010010101111; // 42.0202
#50;
//------------------ new PFU op ------------------
//01000010001001111100000101000111 00111101101001101101000010000001
//0 10000100 101001111100000101000111
//0 01111011 101001101101000010000001
//a exp is bigger by  9
//shifting b right by  9
//0 10000100 101001111100000101000111
//0 01111011 000000000101001101101000
//adding shifted mant
//sign1 + sign2 -
//signs disagree, choosing dominance sign
//raw result	 101001110110110111011110
//1 False False
//Overflow detected not agree
//C no Supp:	 101001110110110111011110
//result mant 	 101001110110110111011110
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//0 10000100 101001110110110111011110
//


op=0;
a=32'b01000001111101100010100001011001; // 30.7697
b=32'b00111100000001001100001101001111; // 0.00810321
ans=32'b01000001111101100011100011110001; // 30.7778
#50;
//------------------ new PFU op ------------------
//01000001111101100010100001011001 00111100000001001100001101001111
//0 10000011 111101100010100001011001
//0 01111000 100001001100001101001111
//a exp is bigger by  11
//shifting b right by  11
//0 10000011 111101100010100001011001
//0 01111000 000000000001000010011000
//adding shifted mant
//sign1 + sign2 -
//signs disagree, choosing dominance sign
//raw result	 111101100001011111000000
//1 False False
//Overflow detected not agree
//C no Supp:	 111101100001011111000000
//result mant 	 111101100001011111000000
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//0 10000011 111101100001011111000000
//


op=1;
a=32'b01000001111100111010110000010001; // 30.459
b=32'b01000001110101001111101101000111; // 26.6227
ans=32'b01000000011101011000011001010000; // 3.83632
#50;
//------------------ new PFU op ------------------
//01000001111100111010110000010001 01000001110101001111101101000111
//0 10000011 111100111010110000010001
//0 10000011 110101001111101101000111
//b exp is bigger by  0
//shifting a right by  0
//0 10000011 111100111010110000010001
//0 10000011 110101001111101101000111
//adding shifted mant
//sign1 + sign2 +
//raw result	 110010001010011101011000
//1 False True
//Overflow detected agree
//C no Supp:	 111001000101001110101100
//result mant 	 111001000101001110101100
//need to normalize by  0  bits
//adjusting exp for overflow ... 1
//shifting c_mant left by  0 bits
//0 10000100 111001000101001110101100
//


op=0;
a=32'b11000000001001111101000110011101; // -2.62217
b=32'b01000001110001011001101110101100; // 24.701
ans=32'b01000001101100001010000101111000; // 22.0788
#50;
//------------------ new PFU op ------------------
//11000000001001111101000110011101 01000001110001011001101110101100
//1 10000000 101001111101000110011101
//0 10000011 110001011001101110101100
//b exp is bigger by  3
//shifting a right by  3
//1 10000000 000101001111101000110011
//0 10000011 110001011001101110101100
//adding shifted mant
//sign1 - sign2 -
//raw result	 001001010110101000011111
//1 True True
//Underflow detected, going to negative
//C no Supp:	 001001010110101000100000
//result mant 	 001001010110101000100000
//need to normalize by  2  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  2 bits
//0 10000001 100101011010100010000011
//


op=0;
a=32'b11000000101101001110100110100001; // -5.65352
b=32'b01000010110010000001010110100011; // 100.042
ans=32'b01000010101111001100011100001001; // 94.3887
#50;
//------------------ new PFU op ------------------
//11000000101101001110100110100001 01000010110010000001010110100011
//1 10000001 101101001110100110100001
//0 10000101 110010000001010110100011
//b exp is bigger by  4
//shifting a right by  4
//1 10000001 000010110100111010011010
//0 10000101 110010000001010110100011
//adding shifted mant
//sign1 - sign2 -
//raw result	 001011001001101111000001
//1 True True
//Underflow detected, going to negative
//C no Supp:	 001011001001101111000010
//result mant 	 001011001001101111000010
//need to normalize by  2  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  2 bits
//0 10000011 101100100110111100001011
//


op=0;
a=32'b01000010001101000110100100101100; // 45.1027
b=32'b11000010000001000010101011111011; // -33.042
ans=32'b01000001010000001111100011000100; // 12.0607
#50;
//------------------ new PFU op ------------------
//01000010001101000110100100101100 11000010000001000010101011111011
//0 10000100 101101000110100100101100
//1 10000100 100001000010101011111011
//b exp is bigger by  0
//shifting a right by  0
//0 10000100 101101000110100100101100
//1 10000100 100001000010101011111011
//adding shifted mant
//sign1 + sign2 +
//raw result	 001110001001010000100111
//1 False True
//Overflow detected agree
//C no Supp:	 100111000100101000010100
//result mant 	 100111000100101000010100
//need to normalize by  0  bits
//adjusting exp for overflow ... 1
//shifting c_mant left by  0 bits
//0 10000101 100111000100101000010100
//


op=1;
a=32'b11000001000011111011001110101010; // -8.98136
b=32'b00111110000000011000000010001010; // 0.126467
ans=32'b11000001000100011011100110101100; // -9.10783
#50;
//------------------ new PFU op ------------------
//11000001000011111011001110101010 00111110000000011000000010001010
//1 10000010 100011111011001110101010
//0 01111100 100000011000000010001010
//a exp is bigger by  6
//shifting b right by  6
//1 10000010 100011111011001110101010
//0 01111100 000000100000011000000010
//adding shifted mant
//sign1 - sign2 +
//signs disagree, choosing dominance sign
//raw result	 011100100101001001010111
//0 True False
//negating result
//C no Supp:	 100011011010110110101000
//result mant 	 100011011010110110101000
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//1 10000010 100011011010110110101000
//


op=0;
a=32'b00111111101011111100111111010111; // 1.37353
b=32'b01000010000101001110101000011000; // 37.2286
ans=32'b01000010000110100110100010010111; // 38.6021
#50;
//------------------ new PFU op ------------------
//00111111101011111100111111010111 01000010000101001110101000011000
//0 01111111 101011111100111111010111
//0 10000100 100101001110101000011000
//b exp is bigger by  5
//shifting a right by  5
//0 01111111 000001010111111001111110
//0 10000100 100101001110101000011000
//adding shifted mant
//sign1 + sign2 -
//signs disagree, choosing dominance sign
//raw result	 011100001001010001100101
//0 True False
//negating result
//C no Supp:	 100011110110101110011010
//result mant 	 100011110110101110011010
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//1 10000100 100011110110101110011010
//


op=1;
a=32'b01000001000010000110001001001000; // 8.52399
b=32'b10111111010000010101001111110111; // -0.755187
ans=32'b01000001000101000111011110000111; // 9.27918
#50;
//------------------ new PFU op ------------------
//01000001000010000110001001001000 10111111010000010101001111110111
//0 10000010 100010000110001001001000
//1 01111110 110000010101001111110111
//a exp is bigger by  4
//shifting b right by  4
//0 10000010 100010000110001001001000
//1 01111110 000011000001010100111111
//adding shifted mant
//sign1 + sign2 -
//signs disagree, choosing dominance sign
//raw result	 011111000100110100001000
//1 False False
//Overflow detected not agree
//C no Supp:	 011111000100110100001000
//result mant 	 011111000100110100001000
//need to normalize by  1  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  1 bits
//0 10000001 111110001001101000010001
//


op=0;
a=32'b00111110010011101110110010011011; // 0.202074
b=32'b11000001000000001101011111101100; // -8.05272
ans=32'b11000000111110110011100001110011; // -7.85064
#50;
//------------------ new PFU op ------------------
//00111110010011101110110010011011 11000001000000001101011111101100
//0 01111100 110011101110110010011011
//1 10000010 100000001101011111101100
//b exp is bigger by  6
//shifting a right by  6
//0 01111100 000000110011101110110010
//1 10000010 100000001101011111101100
//adding shifted mant
//sign1 + sign2 +
//raw result	 100001000001001110011110
//0 False True
//C no Supp:	 100001000001001110011110
//result mant 	 100001000001001110011110
//need to normalize by  0  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  0 bits
//0 10000010 100001000001001110011110
//


op=1;
a=32'b11000010101001011100001010111011; // -82.8803
b=32'b11000010010111110110100111001000; // -55.8533
ans=32'b11000001110110000011011101011100; // -27.027
#50;
//------------------ new PFU op ------------------
//11000010101001011100001010111011 11000010010111110110100111001000
//1 10000101 101001011100001010111011
//1 10000100 110111110110100111001000
//a exp is bigger by  1
//shifting b right by  1
//1 10000101 101001011100001010111011
//1 10000100 011011111011010011100100
//adding shifted mant
//sign1 - sign2 -
//raw result	 111010101000100001011111
//0 True True
//no Underflow for matched sub
//negating result
//C no Supp:	 100010101011101111010000
//result mant 	 100010101011101111010000
//need to normalize by  0  bits
//adjusting exp for overflow ... 1
//shifting c_mant left by  0 bits
//1 10000110 100010101011101111010000
//


op=0;
a=32'b01000001010010101100110101011101; // 12.6751
b=32'b01000001111000010010000000101011; // 28.1407
ans=32'b01000010001000110100001101101101; // 40.8158
#50;
//------------------ new PFU op ------------------
//01000001010010101100110101011101 01000001111000010010000000101011
//0 10000010 110010101100110101011101
//0 10000011 111000010010000000101011
//b exp is bigger by  1
//shifting a right by  1
//0 10000010 011001010110011010101110
//0 10000011 111000010010000000101011
//adding shifted mant
//sign1 + sign2 -
//signs disagree, choosing dominance sign
//raw result	 100001000100011010000010
//0 True False
//negating result
//C no Supp:	 011110111011100101111101
//result mant 	 011110111011100101111101
//need to normalize by  1  bits
//adjusting exp for overflow ... 0
//shifting c_mant left by  1 bits
//1 10000010 111101110111001011111010
//



	end

endmodule