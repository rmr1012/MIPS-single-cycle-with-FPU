# MIPS-single-cycle-with-FPU


Evaluation: Report the following for xc7z020clg484-1 FPGA
ASM1(Floating Point)  
Area: Number of LUT, LUTRAM, and FF  
LUT: 1928  
LUTRAM: 96
FF: 516  
Time: Minimum clock period supported by the design in ns   
30ns  
Number of clock cycle to execute the above-mentioned assembly codes  
105 Cycles  
Power consumption (should not exceed the safe limit reported by Vivado) in watts  
0.13W  
Cost Function = (percentage usage of LUT + percentage usage of FF) × clock period × number of clock cycle × power = (percentage usage of LUT + percentage usage of FF) × energy The unit of energy should be nJ (nano joule)  
Report the values of the cost function for both the assembly codes.  
(3.62+0.48) + 30 x 105 x 0.13W = 1678.95 nJ  

ASM1(No Floating Point)   
Area: Number of LUT, LUTRAM, and FF  
LUT: 1252  
LUTRAM: 48  
FF: 516  
Time: Minimum clock period supported by the design in ns  
11ns  
Number of clock cycle to execute the above-mentioned assembly codes  
9 Cycles  
Power consumption (should not exceed the safe limit reported by Vivado) in watts  
0.11W  
Cost Function = (percentage usage of LUT + percentage usage of FF) × clock period × number of clock cycle × power = (percentage usage of LUT + percentage usage of FF) × energy The unit of energy should be nJ (nano joule)  
Report the values of the cost function for both the assembly codes.  
(2.35+0.48) + 11 x 30 x 0.142W = 132.61 nJ  
