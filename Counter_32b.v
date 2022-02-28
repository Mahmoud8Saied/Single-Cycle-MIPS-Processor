module Counter_32b (
    input wire [31:0] IN,
    input wire        clk,
    input wire        rst,

    output reg [31:0] Counter_Value
);

always @ (posedge clk or negedge rst )
begin
    if (!rst)
    begin
        Counter_Value <= 32'b0;
    end 
    else 
    begin
        Counter_Value <= Counter_Value + 32'b1;
    end 
end

endmodule