
module MIPS_12(input clk, rst,
output y );


  logic [5:0] PC;
  logic [5:0] PC_next; // the only state vars, rest are connections

  logic [5:0] PC_4,b_addr;
  logic [4:0] wn;
  wire [31:0] instruction, alu_result;
  logic [31:0] b,data_out;
  logic [31:0] data,rd1,rd2,wd;
  logic	RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,PCSrc,Branch,alu_zero;
  logic [2:0] alu_op;// translated alu op

  logic halt;


  assign clk_internal = clk && !halt;
  assign y = ^alu_result;

  InstructionMemory im (
    .PC(PC),
    .instruction(instruction),
    .halt(halt),
	.rst(rst)
  );

  Control ctrl(
    .ins_H(instruction[31:26]),
    .ins_L(instruction[5:0]),
    .RegDst(RegDst),
    .Branch(Branch),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemToReg(MemToReg),
    .PCSrc(PCSrc),
    .outOp(alu_op)
  );
  RegisterFile regFile (
    .rs(instruction[25:21]),
    .rt(instruction[20:16]), // break down instruciton
    .wn(wn),
    .wd(wd),
    .RegWrite(RegWrite),
    .rd1(rd1),
    .rd2(rd2),
    .rst(rst),
    .clk(clk_internal)
  );



  ALU alu_m(
    .a(rd1),// connect Reg to ALU
    .b(b),
    .op(alu_op),
    .c(alu_result),
    .zero(alu_zero)
  );
  DataMemory dm (
    .address(alu_result),
    .data_in(rd2),
    .data_out(data_out),
    .memRead(MemRead),
    .memWrite(MemWrite),
	.clk(clk_internal)
  );




always_comb begin

  PC_4= PC+4;
  b_addr = PC_4+ ({ {14{instruction[15]}},instruction[15:0] , 2'b00} ); // ALU top right
  PC_next = (Branch && alu_zero) ? b_addr : PC_4; // top right mux
  PC_next = PCSrc ? instruction[25:0]<<2 : PC_next; // top right mux
  b = ALUSrc ?  { {16{instruction[15]}} ,instruction[15:0]} : rd2 ; // choose either sign extention or reg RegisterFile

  wn = RegDst ? instruction[15:11] : instruction[20:16];

end

assign wd = MemToReg ? data_out : alu_result; // mux right of datamem

  always @ (posedge clk_internal) begin
    PC=rst ? 0 :PC_next;
  end

endmodule
