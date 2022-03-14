module Register (
    output reg   [31:0]   Reg_out,

    input  wire  [31:0]   Reg_in,
    input  wire           Reg_clk,
    input  wire           Reg_rst
);

always @ (posedge Reg_clk or negedge Reg_rst)
begin 
    if (!Reg_rst)
        Reg_out <= 16'b0;
        
    else
        Reg_out <= Reg_in;
end

endmodule