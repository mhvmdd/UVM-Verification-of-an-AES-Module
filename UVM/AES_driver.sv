package AES_driver_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import AES_transaction_pkg::*;

    class AES_driver extends uvm_driver#(AES_seq_item);
        `uvm_component_utils(AES_driver)

        virtual AES_intf AES_vif;

        AES_seq_item seq_item;

        function new(string name = "AES_driver", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            if (!uvm_config_db#(virtual AES_intf)::get(this, "", "AES_vif", AES_vif)) begin
                `uvm_fatal("AES_DRIVER", "Virtual interface not found in config DB")
            end else begin
                `uvm_info("AES_DRIVER", "Virtual interface found and set in config DB", UVM_LOW)
            end

            seq_item = AES_seq_item::type_id::create("AES_seq_item");

        endfunction

        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                seq_item_port.get_next_item(seq_item);

                AES_vif.rst_n <= seq_item.rst_n;
                AES_vif.plain_text <= seq_item.plain_text;
                AES_vif.cipher_key <= seq_item.cipher_key;
                AES_vif.valid_in <= seq_item.valid_in;
                AES_vif.enc_dec <= seq_item.enc_dec;
                repeat(2)@(AES_vif.cb);

                // wait (AES_vif.valid_out == 1);

                seq_item_port.item_done();
            end
        endtask

    endclass : AES_driver

endpackage : AES_driver_pkg