module mem#(parameter WORD_SIZE = 128) (
    input clk,
    input rst_n,
    input [WORD_SIZE-1:0] data_in,
    input data_valid,
    output reg [WORD_SIZE-1:0] data_out,
    output reg data_out_valid
);

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out <= '0;
        data_out_valid <= 1'b0;
    end else if (data_valid) begin
        data_out <= data_in;
        data_out_valid <= 1'b1;
    end else begin
        data_out_valid <= 1'b0;
    end
end
endmodule