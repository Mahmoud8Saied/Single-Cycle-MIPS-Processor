module Data_Memory (
    input   wire              clk, WE, rst, 
    input   wire    [31:0]    A,
    input   wire    [31:0]    WD,

    output  wire    [31:0]    RD,
    output  wire    [15:0]    Test_value
);


reg   [31:0]   ram    [0:99];

integer i;

always @(posedge clk or negedge rst)
    begin
        if (!rst)
            begin 
                for (i=0; i<100; i=i+1)
                    begin
                        ram [i] <= 32'b0;
                    end
            end 
        else if (WE)
            begin
                ram[A] <= WD;
            end
        // dout = ram[A];  // will build the ram memory from BRAM inside the FPGA not logic elements
    end

assign Test_value = ram [32'b0]; // Puts the value of address 0 inside TestValue

assign RD = ram[A]; // will build the ram memory from logic elements instead block ram

endmodule 