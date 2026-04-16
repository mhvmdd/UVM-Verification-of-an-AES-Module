package AES_monitor_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"


    import AES_transaction_pkg::*;

    class AES_monitor extends uvm_monitor;
        `uvm_component_utils(AES_monitor)

        AES_seq_item seq_item;
        virtual AES_intf AES_vif;

        uvm_analysis_port#(AES_seq_item) ap;

        function new(string name = "AES_monitor", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            seq_item = AES_seq_item::type_id::create("seq_item", this);
            ap = new("ap", this);

            if (!uvm_config_db#(virtual AES_intf)::get(this, "", "AES_vif", AES_vif)) begin
                `uvm_fatal("AES_MONITOR", "Virtual interface not found in config DB")
            end else begin
                `uvm_info("AES_MONITOR", "Virtual interface found and set in config DB", UVM_LOW)
            end
        endfunction

        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                repeat(2)@(AES_vif.cb);
                seq_item.rst_n <= AES_vif.rst_n;
                seq_item.plain_text <= AES_vif.plain_text;
                seq_item.cipher_key <= AES_vif.cipher_key;
                seq_item.valid_in <= AES_vif.valid_in;
                seq_item.valid_out <= AES_vif.valid_out;
                seq_item.cipher_text <= AES_vif.cipher_text;
                seq_item.enc_dec <= AES_vif.enc_dec;
                #1step ap.write(seq_item);
            end
        endtask

    endclass : AES_monitor


endpackage : AES_monitor_pkg