package AES_transaction_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class AES_seq_item extends uvm_sequence_item;
        `uvm_object_utils(AES_seq_item)

        rand logic rst_n;
        rand logic [127:0] plain_text;
        rand logic [127:0] cipher_key;
        rand logic valid_in;
        logic [127:0] cipher_text;
        logic valid_out;

        rand logic enc_dec; // 1 for encryption, 0 for decryption

        function new(string name = "AES_seq_item");
            super.new(name);
        endfunction

        function string display();
            return $sformatf("AES_seq_item: rst_n=%b, plain_text=%h, cipher_key=%h, valid_in=%b, cipher_text=%h, valid_out=%b",
                rst_n, plain_text, cipher_key, valid_in, cipher_text, valid_out);
        endfunction

        //TODO: Randomization logic for the sequence item fields
        constraint reset_c {
            rst_n dist {0:=1, 1:=9}; // 10% reset, 90% normal operation
        }; 
        constraint valid_in_c {
            valid_in dist {0:=1, 1:=9}; // 10% invalid, 90% valid
        };

        // Constraint to ensure `plain_text` and `cipher_key` are not equal
        constraint plain_text_not_equal_key_c {
            plain_text != cipher_key;
        }

        // Constraint to limit `plain_text` to a specific range
        constraint plain_text_range_c {
            plain_text dist {128'h00000000000000000000000000000000:/ 1, [128'h00000000000000000000000000000001 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE] :/ 8 ,128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF :/ 1}; // Uniform distribution over the entire range
        }


        // Constraint to ensure `cipher_key` has a specific pattern (e.g., alternating bits)
        constraint cipher_key_pattern_c {
            cipher_key dist {{64{2'b10}}:/1, {64{2'b01}}:/1, 128'h00000000000000000000000000000000:/ 1, [128'h00000000000000000000000000000001 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE] :/ 8 ,128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF :/ 1}; // 50% chance of alternating bits pattern
        }


        constraint enc_dec_c {
            enc_dec dist {0:=1, 1:=3}; // 75% encryption, 25% decryption
        }

    endclass : AES_seq_item


endpackage