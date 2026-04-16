interface AES_intf (input logic clk);

    logic rst_n;
    logic [127:0] plain_text;
    logic [127:0] cipher_key;
    logic valid_in;
    logic [127:0] cipher_text;
    logic valid_out;
    logic enc_dec; // 1 for encryption, 0 for decryption



    clocking cb @(posedge clk);
        output plain_text, cipher_key, valid_in, enc_dec;
        input cipher_text, valid_out;
    endclocking

endinterface
