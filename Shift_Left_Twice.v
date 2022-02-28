module Shift_Left_Twice # (parameter Width= 6) (
    input wire    [Width - 1:0]  IN,
    output wire   [width - 1:0]  OUT
); 

assign OUT = IN << 2;

endmodule