module AES_top;
import uvm_pkg::*;
import AES_Test_pkg::*;
`include "uvm_macros.svh"

bit clk;

always #5 clk = ~clk;

AES_intf AES_if(clk);

AES_Wrapper aes_wrapper (
    .clk(AES_if.clk),
    .rst_n(AES_if.rst_n),
    .plain_text(AES_if.plain_text),
    .cipher_key(AES_if.cipher_key),
    .valid_in(AES_if.valid_in),
    .cipher_text(AES_if.cipher_text),
    .valid_out(AES_if.valid_out),
    .enc_dec(AES_if.enc_dec)
);



initial begin
    uvm_config_db#(virtual AES_intf)::set(null, "uvm_test_top", "AES_vif", AES_if);
    run_test("AES_Test");
end
endmodule 
