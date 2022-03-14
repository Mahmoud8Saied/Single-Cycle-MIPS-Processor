module MIPS_Final (
    output    wire     [15:0]    Test_Value,

    input     wire               clk,rst 
);

wire               MemWrite_F;
wire    [31:0]     PC_F, ALUOUT_F, writeData_F, ReadData, Instr_F;

MIPS_Processor MP (
    .PC_M           (PC_F),
    .ALU_OUT_M      (ALUOUT_F),
    .writeData_M    (writeData_F),
    .MemWrite_M     (MemWrite_F),

    .Instr_M        (Instr_F), 
    .RD_M           (ReadData),
    .clk_M          (clk), 
    .rst_M          (rst)
);

Instruction_Memory IM (
    .PC     (PC_F),

    .Instr  (Instr_F)
);

Data_Memory DM (
    .clk          (clk), 
    .rst          (rst),

    .WE           (MemWrite_F), 
    .A            (ALUOUT_F),
    .WD           (writeData_F),

    .RD           (ReadData),
    .Test_value   (Test_Value)
);

endmodule