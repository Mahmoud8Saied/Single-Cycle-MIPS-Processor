module top_module (
    output    wire    [7:0]   Result,
    output    wire    [3:0]   tube_enables,
    input     wire            clk,
    input     wire            rst
);

wire  clk_div1, clk_div2;
wire  [15:0] test_value;
wire  [1:0]  pointer;


MIPS_Final Unit_MP (
    .Test_Value(test_value),
    .clk(clk_div1),
    .rst(rst)
);


clock_divider U0_clock_divider (
    .clk_div1(clk_div1),
    .clk_div2(clk_div2),
    .ref_clk(clk),
    .rst(rst)
);


dig_pointer U2_pointer (
    .pointer(pointer),
    .clk(clk_div2),
    .rst(rst)
);

seg_disp U3_seg_disp (
    .Result(Result),
    .tube_enables(tube_enables),
    .count_val(test_value),
    .dig_pointer(pointer),
    .clk(clk_div2),
    .rst(rst)
);

endmodule