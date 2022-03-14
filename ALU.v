module ALU (

    input  wire  [31:0] A, B,

    input  wire  [2:0] ALU_FUNC,

    output reg   [31:0] ALU_OUT,

    output wire  Zero_Flag
);

// Any number write it in the following format : (number of bits)'b(value in binary)

always @ (*)
begin
    case (ALU_FUNC)

            3'b000: 
                begin
                 ALU_OUT = (A & B);
                end

            3'b001: 
                begin
                 ALU_OUT = (A | B);
                end

            3'b010:
                begin
                 ALU_OUT = A + B;
                end

            3'b100:
                begin
                    ALU_OUT = A - B;
                end

            3'b101: 
                begin
                 ALU_OUT = A * B;
                end

            3'b110: 
                begin
                if (A < B)
                  begin
                    ALU_OUT = 32'b1;
                  end
                else 
                  begin
                    ALU_OUT = 32'b0;
                  end
                end
      
            default:  ALU_OUT = 32'b0;
    endcase

end

assign Zero_Flag = (ALU_OUT == 32'b0);

endmodule
