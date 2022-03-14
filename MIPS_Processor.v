module MIPS_Processor (
    output    wire       [31:0]      PC_M,
    output    wire       [31:0]      ALU_OUT_M,
    output    wire       [31:0]      writeData_M,
    output    wire                   MemWrite_M,

    input     wire       [31:0]      Instr_M, RD_M,
    input     wire                   clk_M, rst_M
);

wire            Jump, MemtoReg, Branch, ALUSrc, RegDst, RegWrite; 
wire  [2:0]     ALUControl;

Control_Unit CU (
   . Jump_C          (Jump),
   . MemtoReg_C      (MemtoReg),   
   . MemWrite_C      (MemWrite_M),
   . Branch_C        (Branch),
   . ALUSrc_C        (ALUSrc),
   . RegDst_C        (RegDst),
   . RegWrite_C      (RegWrite),
   . ALUControl_C    (ALUControl),

   . Opcode_C        (Instr_M [31:26]),
   . Funct_C         (Instr_M [5:0])
);

Datapath DP (
    .PC_Datapath        (PC_M),
    .ALU_Out_Datapath   (ALU_OUT_M),
    .writeData_D        (writeData_M),

    .RegWrite_D         (RegWrite),
    .RegDst_D           (RegDst), 
    .ALUSrc_D           (ALUSrc), 
    .MemToReg_D         (MemtoReg), 
    .Branch_D           (Branch), 
    .Jump_D             (Jump), 
    .ALUControl_D       (ALUControl), 
    .clk_Datapath       (clk_M), 
    .rst_Datapath       (rst_M), 

    .Instr_Datapath     (Instr_M),
    .RD_Datapath        (RD_M)
);

endmodule