package AES_env_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import AES_agent_pkg::*;
    import AES_scoreboard_pkg::*;
    import AES_subscriber_pkg::*;

    class AES_env extends uvm_env;
        `uvm_component_utils(AES_env)

        AES_agent agent;
        AES_scoreboard scoreboard;
        AES_subscriber subscriber;

        virtual AES_intf AES_vif;

        function new(string name = "AES_env", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            agent = AES_agent::type_id::create("agent", this);
            scoreboard = AES_scoreboard::type_id::create("scoreboard", this);
            subscriber = AES_subscriber::type_id::create("subscriber", this);

            if (!uvm_config_db#(virtual AES_intf)::get(this, "", "AES_vif", AES_vif)) begin
                `uvm_fatal("AES_ENV", "Virtual interface not found in config DB")
            end else begin
                `uvm_info("AES_ENV", "Virtual interface found and set in config DB", UVM_LOW)
            end

            uvm_config_db#(virtual AES_intf)::set(this, "agent", "AES_vif", AES_vif);
        endfunction

        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
             agent.ap.connect(scoreboard.imp);
             agent.ap.connect(subscriber.analysis_export);

        endfunction

    endclass : AES_env

endpackage : AES_env_pkg