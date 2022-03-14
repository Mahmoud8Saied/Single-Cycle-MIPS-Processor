module Instruction_Memory (
    input wire  [31:0] PC,
    output wire [31:0] Instr
);

reg   [31:0]   ROM   [0:99];

initial 
    begin00
        $readmemh ("Fibonacci.txt", ROM);
    end

assign Instr = ROM[PC >> 2];

endmodule 