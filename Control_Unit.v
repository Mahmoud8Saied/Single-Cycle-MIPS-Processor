module Control_Unit (  
   output wire           Jump_C,
   output wire           MemtoReg_C,   
   output wire           MemWrite_C,
   output wire           Branch_C,
   output wire           ALUSrc_C,
   output wire           RegDst_C,
   output wire           RegWrite_C,
   output wire    [2:0]  ALUControl_C,

   input wire     [5:0]  Opcode_C,
   input wire     [5:0]  Funct_C
);

// Intermediate Signals:
wire [1:0] ALUOp_D;

// Modules Instantiations

// ALU Decoder:

ALU_Decoder AD (
    .ALUOp (ALUOp_D),
    .Funct (Funct_C),

    .ALUControl (ALUControl_C)
);

// Main Decoder:

Main_Decoder MD (
   .Opcode (Opcode_C),

   .Jump (Jump_C),
   .MemtoReg (MemtoReg_C),   
   .MemWrite (MemWrite_C),
   .Branch (Branch_C),
   .ALUSrc (ALUSrc_C),
   .RegDst (RegDst_C),
   .RegWrite (RegWrite_C),
   .ALUOp (ALUOp_D)     
);

endmodule