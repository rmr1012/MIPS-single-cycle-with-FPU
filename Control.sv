

module Control(
	input[5:0]	ins_H,ins_L,
	output logic RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemToReg,PCSrc,Branch,
	output logic [2:0]outOp
);
logic [1:0] ALUOp;

always_comb begin
//	if (rst) begin
//		RegDst=0; ALUSrc=0; MemToReg=0; RegWrite=1; MemRead=0; MemWrite=0; Branch=0; PCSrc=0; ALUOp=2'b00;
//	end
	case(ins_H)
		6'b001000: begin RegDst=0; ALUSrc=1; MemToReg=0; RegWrite=1; MemRead=0; MemWrite=0; Branch=0; PCSrc=0; ALUOp=2'b00;end // addi
		6'b000000: begin RegDst=1; ALUSrc=0; MemToReg=0; RegWrite=1; MemRead=0; MemWrite=0; Branch=0; PCSrc=0; ALUOp=2'b10;end // Rtype
		6'b100011: begin RegDst=0; ALUSrc=1; MemToReg=1; RegWrite=1; MemRead=1; MemWrite=0; Branch=0; PCSrc=0; ALUOp=2'b00;end // lw
		6'b101011: begin RegDst=0; ALUSrc=1; MemToReg=0; RegWrite=0; MemRead=0; MemWrite=1; Branch=0; PCSrc=0; ALUOp=2'b00;end //sw
		6'b000100: begin RegDst=0; ALUSrc=0; MemToReg=0; RegWrite=0; MemRead=0; MemWrite=0; Branch=1; PCSrc=0; ALUOp=2'b01;end //beq
		6'b000010: begin RegDst=0; ALUSrc=0; MemToReg=0; RegWrite=0; MemRead=0; MemWrite=0; Branch=0; PCSrc=1; ALUOp=2'b01;end //jump
		default:   begin RegDst=0; ALUSrc=0; MemToReg=0; RegWrite=1; MemRead=0; MemWrite=0; Branch=0; PCSrc=0; ALUOp=2'b00;end // this is a unicorn condition
	endcase

	if 	(ALUOp==2'b00) begin outOp=3'b010; end // addi lw, sw
	else if (ALUOp==2'b01) begin outOp=3'b110; end // beq,bne
	else if (ALUOp[1] && ins_L==6'b100000) begin outOp=3'b010; end //add
	else if (ALUOp[1] && ins_L==6'b100010) begin outOp=3'b110; end //sub
	else if (ALUOp[1] && ins_L==6'b100100) begin outOp=3'b000; end //and
	else if (ALUOp[1] && ins_L==6'b100101) begin outOp=3'b001; end // or
	else if (ALUOp[1] && ins_L==6'b101010) begin outOp=3'b111; end //slt
	else begin outOp=3'b011; end // this should never happen,

end


endmodule
