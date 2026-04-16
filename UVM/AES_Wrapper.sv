module AES_Wrapper (
    input clk,
    input rst_n,
    input [127:0] plain_text,
    input [127:0] cipher_key,
    input valid_in,
    input enc_dec, // 1 for encryption, 0 for decryption

    output reg [127:0] cipher_text,
    output reg valid_out
);

//Wrapper Signals

    wire valid_out_in;
    wire valid_out_key;
    wire valid_out_flag;


    wire valid_in_out;
    assign valid_in_out = valid_out_in & valid_out_key & valid_out_flag;

//AES Signals

    wire [127:0] in;
    wire [127:0] key;
    wire [127:0] out;
    wire flag;

    mem mem_in (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(plain_text),
        .data_valid(valid_in),
        .data_out(in),
        .data_out_valid(valid_out_in)
    );

     mem mem_key (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(cipher_key),
        .data_valid(valid_in),
        .data_out(key),
        .data_out_valid(valid_out_key)
    );

    mem #(.WORD_SIZE(1))mem_flag (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(enc_dec),
        .data_valid(valid_in),
        .data_out(flag),
        .data_out_valid(valid_out_flag)
    );

    // AES_Encrypt a(in, key, out);
    AES a(in, key, out, flag);

     mem mem_out (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(out),
        .data_valid(valid_in_out),
        .data_out(cipher_text),
        .data_out_valid(valid_out)
    );

endmodule