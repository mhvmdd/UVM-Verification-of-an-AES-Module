package AES_Test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import AES_env_pkg::*;
    import AES_sequences_pkg::*;

    class AES_Test extends uvm_test;
        `uvm_component_utils(AES_Test)

        AES_env env;
        virtual AES_intf AES_vif;

        AES_sequence_Reset reset_seq;
        AES_sequence_Decrypt decrypt_seq;
        AES_sequence_Encrypt encrypt_seq;
        AES_sequence_Both both_seq;

        function new(string name = "AES_Test", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            env = AES_env::type_id::create("env", this);
            encrypt_seq = AES_sequence_Encrypt::type_id::create("encrypt_seq");
            decrypt_seq = AES_sequence_Decrypt::type_id::create("decrypt_seq");
                reset_seq = AES_sequence_Reset::type_id::create("reset_seq");
                both_seq = AES_sequence_Both::type_id::create("both_seq");  
            if (!uvm_config_db#(virtual AES_intf)::get(this, "", "AES_vif", AES_vif)) begin
                `uvm_fatal("AES_Test", "Virtual interface not found in config DB")
            end else begin
                `uvm_info("AES_Test", "Virtual interface found and set in config DB", UVM_LOW)
            end 

            uvm_config_db#(virtual AES_intf)::set(this, "env", "AES_vif", AES_vif);

        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            // `uvm_info("AES_Test", "Running AES Test", UVM_LOW)
            phase.raise_objection(this);
            reset_seq.start(env.agent.sequencer);
            encrypt_seq.start(env.agent.sequencer);
            // decrypt_seq.start(env.agent.sequencer);
            // both_seq.start(env.agent.sequencer);
            phase.drop_objection(this);
        endtask

    endclass : AES_Test

endpackage : AES_Test_pkg