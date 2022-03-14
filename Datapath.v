module Datapath (
    output   wire   [31:0]    PC_Datapath,
    output   wire   [31:0]    ALU_Out_Datapath,
    output   wire   [31:0]    writeData_D,

    input    wire             RegWrite_D, RegDst_D, ALUSrc_D, MemToReg_D, Branch_D, Jump_D, 
    input    wire   [2:0]     ALUControl_D, 
    input    wire             clk_Datapath, rst_Datapath, 
    input    wire   [31:0]    Instr_Datapath,
    input    wire   [31:0]    RD_Datapath
);

wire                   Zero_signal, PCSrc;
wire       [31:0]      RD1, Result, B_ALU, Signlmm_D, PCPlus4, PCBranch, Signlmm_Shifted;
wire       [31:0]      PC1, PC2, PCJump; 
wire       [27:0]      Instr_Shifted;
wire       [4:0]       writeAddr_D;

assign PCSrc   = Branch_D & Zero_signal;

assign PCJump  = {PCPlus4 [31:28] , Instr_Shifted};

ALU A (
    .A         (RD1), 
    .B         (B_ALU),
    .ALU_FUNC  (ALUControl_D),

    .ALU_OUT   (ALU_Out_Datapath),
    .Zero_Flag (Zero_signal)
);

Register_File RF (
    .readData1    (RD1), 
    .readData2    (writeData_D),

    .writeData    (Result),
    .readAddr1    (Instr_Datapath [25:21]), 
    .readAddr2    (Instr_Datapath [20:16]), 
    .writeAddr    (writeAddr_D),
    .writeEnable  (RegWrite_D), 
    .clk          (clk_Datapath), 
    .reset        (rst_Datapath) 
);

Register PC_reg (
    .Reg_out (PC_Datapath),

    .Reg_in  (PC2),
    .Reg_clk (clk_Datapath),
    .Reg_rst (rst_Datapath)
);

MUX #(.Width(32)) DataMemMux (
    .IN0 (ALU_Out_Datapath),
    .IN1 (RD_Datapath),
    .sel (MemToReg_D),

    .OUT (Result)
);

MUX #(.Width(32)) ALU_Mux (
    .IN0 (writeData_D),
    .IN1 (Signlmm_D),
    .sel (ALUSrc_D),

    .OUT (B_ALU)
);

MUX #(.Width(5)) WriteAddrMux (
    .IN0 (Instr_Datapath [20:16]),
    .IN1 (Instr_Datapath [15:11]),
    .sel (RegDst_D),

    .OUT (writeAddr_D)
);

MUX #(.Width(32)) PCMUX1 (
    .IN0 (PCPlus4),
    .IN1 (PCBranch),
    .sel (PCSrc),

    .OUT (PC1)
);

MUX #(.Width(32)) PCMUX2 (
    .IN0 (PC1),
    .IN1 (PCJump),
    .sel (Jump_D),

    .OUT (PC2)
);

Adder PC4 (
    .A (PC_Datapath),
    .B (32'd4),

    .C (PCPlus4)
);

Adder PC_Branch (
    .A (Signlmm_Shifted),
    .B (PCPlus4),

    .C (PCBranch)
);

Sign_Extend S (
    .Inst    (Instr_Datapath [15:0]),

    .Signlmm (Signlmm_D)
);

Shift_Left_Twice #(.Width(32)) SL1 (
    .IN  (Signlmm_D),

    .OUT (Signlmm_Shifted)
);

Shift_Left_Twice #(.Width(28) ) SL2 (
    .IN  ({2'b0,Instr_Datapath [25:0]}),

    .OUT (Instr_Shifted)
);

endmodule