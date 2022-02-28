module Sign_Extend (
    input  wire [15:0] Inst,
    output wire  [31:0] Signlmm
);

    assign Signlmm = { {16{Inst[15]}} , Inst};

endmodule