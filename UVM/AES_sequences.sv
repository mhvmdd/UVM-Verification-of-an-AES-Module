package AES_sequences_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import AES_transaction_pkg::*;

    // class AES_sequence_Encypt extends uvm_sequence;
    //     `uvm_object_utils(AES_sequence_Encypt)
    //     AES_seq_item seq_item;

    //     function new(string name = "AES_sequence_Encypt");
    //         super.new(name);
    //     endfunction


    //     task pre_body();
    //         seq_item = AES_seq_item::type_id::create("seq_item");
    //         `uvm_info(get_type_name(), "Starting AES_sequence1", UVM_LOW)
    //     endtask

    //     task body();
    //         // Here you can set the fields of seq_item as needed
    //         //TODO: set fields of seq_item 

    //         repeat(2) begin
    //             start_item(seq_item);
    //             // Reset
    //             seq_item.rst_n = 0;
    //             seq_item.plain_text = 128'h0; // Example plaintext
    //             seq_item.cipher_key = 128'h0; // Example key
    //             seq_item.valid_in = 1'b0;
    //             finish_item(seq_item);
    //             // #10ns; // Wait for some time before deasserting reset
    //         end



    //         repeat (50) begin
    //             start_item(seq_item);
    //             // Normal operation
    //             seq_item.randomize(); // Randomize the fields of seq_item
    //             finish_item(seq_item);
    //         end
    //     endtask


    // endclass : AES_sequence_Encypt

    class AES_sequence_Reset extends uvm_sequence;
        `uvm_object_utils(AES_sequence_Reset)
        AES_seq_item seq_item;

        function new(string name = "AES_sequence_Reset");
            super.new(name);
        endfunction

        task pre_body ();
             seq_item = AES_seq_item::type_id::create("seq_item");
            `uvm_info(get_type_name(), "Starting AES_sequence_Reset", UVM_LOW)
        endtask

        task body();
            start_item(seq_item);
            seq_item.rst_n = 0;
            seq_item.valid_in = 1'b0;
            finish_item(seq_item);
        endtask
    endclass : AES_sequence_Reset

    class AES_sequence_Encrypt extends uvm_sequence;
        `uvm_object_utils(AES_sequence_Encrypt)
        AES_seq_item seq_item;

        function new(string name = "AES_sequence_Encrypt");
            super.new(name);
        endfunction

        task pre_body ();
             seq_item = AES_seq_item::type_id::create("seq_item");
            `uvm_info(get_type_name(), "Starting AES_sequence_Reset", UVM_LOW)
        endtask
        task body();
            repeat (50) begin
                start_item(seq_item);
                seq_item.randomize();
                seq_item.enc_dec = 1'b1; // Set enc_dec to 1 for encryption
                finish_item(seq_item);
            end
        endtask
    endclass : AES_sequence_Encrypt

    class AES_sequence_Decrypt extends uvm_sequence;
        `uvm_object_utils(AES_sequence_Decrypt)
        AES_seq_item seq_item;

        function new(string name = "AES_sequence_Decrypt");
            super.new(name);
        endfunction

        task pre_body ();
             seq_item = AES_seq_item::type_id::create("seq_item");
            `uvm_info(get_type_name(), "Starting AES_sequence_Reset", UVM_LOW)
        endtask
        task body();
            repeat (50) begin
                start_item(seq_item);
                seq_item.randomize();
                seq_item.enc_dec = 1'b0; // Set enc_dec to 0 for decryption
                finish_item(seq_item);
            end
        endtask
    endclass : AES_sequence_Decrypt

    class AES_sequence_Both extends uvm_sequence;
        `uvm_object_utils(AES_sequence_Both)
        AES_seq_item seq_item;

        function new(string name = "AES_sequence_Both");
            super.new(name);
        endfunction

        task pre_body ();
             seq_item = AES_seq_item::type_id::create("seq_item");
            `uvm_info(get_type_name(), "Starting AES_sequence_Reset", UVM_LOW)
        endtask
        task body();
            repeat (25) begin
                start_item(seq_item);
                seq_item.randomize();
                finish_item(seq_item);
            end
        endtask
    endclass : AES_sequence_Both

endpackage : AES_sequences_pkg