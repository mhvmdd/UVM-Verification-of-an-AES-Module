package AES_subscriber_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import AES_transaction_pkg::*;


    class AES_subscriber extends uvm_subscriber #(AES_seq_item);
        `uvm_component_utils(AES_subscriber)


        AES_seq_item seq_item;

        covergroup AES_cg;
            rst_n_cp : coverpoint seq_item.rst_n {
                bins rst_n_0 = {0};
                bins rst_n_1 = {1};
                bins rst_n_transition = (0 => 1) ;
                bins rst_n_transition_back = (1 => 0) ;
            }
            valid_in_cp : coverpoint seq_item.valid_in {
                bins valid_in_0 = {0};
                bins valid_in_1 = {1};
                bins valid_in_transition = (0 => 1) ;
                bins valid_in_transition_back = (1 => 0) ;
            }
            valid_out_cp : coverpoint seq_item.valid_out {
                bins valid_out_0 = {0};
                bins valid_out_1 = {1};
                bins valid_out_transition = (0 => 1) ;
                bins valid_out_transition_back = (1 => 0) ;
            }
            cipher_text_cp : coverpoint seq_item.cipher_text {
                bins cipher_text_0 = {128'h0};
                bins cipher_text_non_zero = {[128'h1 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF]};
            }
            plain_text_cp : coverpoint seq_item.plain_text {
                bins plain_text_0 = {128'h0};
                bins plain_text_non_zero = {[128'h1 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF]};
                bins plain_text_pattern = {128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF};
            }
            key_cp : coverpoint seq_item.cipher_key {
                bins key_0 = {128'h0};
                bins key_non_zero = {[128'h1 : 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF]};
                bins key_pattern = {128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA};
            }
        endgroup 


        function new(string name = "AES_subscriber", uvm_component parent = null);
            super.new(name, parent);
            AES_cg = new;
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            seq_item = AES_seq_item::type_id::create("seq_item", this);
        endfunction

        function void write (AES_seq_item t);
            seq_item = t;
            AES_cg.sample();
        endfunction


    endclass : AES_subscriber

endpackage : AES_subscriber_pkg