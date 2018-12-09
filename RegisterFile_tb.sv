

module tb_RF;

logic [4:0] rs,rt,wn;
logic [31:0] wd;
logic RegWrite;
logic [31:0] rd1, rd2;


RegisterFile uut (
.rs(rs),
.rt(rt),
.wn(wn), 
.wd(wd),
.RegWrite(RegWrite),
.rd1(rd1), 
.rd2(rd2)
);


initial begin
RegWrite=1;
rs=5'b0001;
rt=5'b0010;
wn=5'b0011;
wd=32'h55555555;
#10
RegWrite=0;
rs=5'b0001;
rt=5'b0011;



end


endmodule