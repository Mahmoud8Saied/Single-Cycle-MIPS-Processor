module Register_File ( 
    output wire  [31:0]                 readData1, readData2,
    input  wire  [31:0]                 writeData,
    input  wire  [$clog2 (32)-1:0]      readAddr1, readAddr2, writeAddr,
    input  wire                         writeEnable, 
    input  wire                         clk, 
    input  wire                         reset
);

reg [31:0] MEM [0:31];
integer i;

always @ (negedge clk or negedge reset)
    begin
        if (!reset)
            begin 
                for (i=0; i<32; i=i+1)
                    begin
                        MEM [i] <= { (32) {1'b0} };
                    end
            end
        else if (writeEnable) 
            begin
                MEM[writeAddr] <= writeData;
            end
    end 
assign readData1 = MEM[readAddr1];
assign readData2 = MEM[readAddr2];

endmodule