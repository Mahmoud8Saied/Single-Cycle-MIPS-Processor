module MUX #(parameter Width = 2) (
    input wire [Width - 1:0] IN0,
    input wire [Width - 1:0] IN1,
    input wire       sel,  

    output reg [Width - 1:0] OUT
);

always @ (*)
begin
    if (sel)
        OUT = IN1;

    else 
        OUT = IN0;
end


endmodule