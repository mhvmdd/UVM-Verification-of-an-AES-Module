package AES_agent_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import AES_monitor_pkg::*;
    import AES_driver_pkg::*;
    import AES_sequencer_pkg::*;

    import AES_transaction_pkg::*;

    class AES_agent extends uvm_agent;
        `uvm_component_utils(AES_agent)

        AES_monitor monitor;
        AES_driver driver;
        AES_sequencer sequencer;

        virtual AES_intf AES_vif;

        uvm_analysis_port#(AES_seq_item) ap;

        function new(string name = "AES_agent", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            monitor = AES_monitor::type_id::create("monitor", this);
            driver = AES_driver::type_id::create("driver", this);
            sequencer = AES_sequencer::type_id::create("sequencer", this);
    
            ap = new("ap", this);

            if (!uvm_config_db#(virtual AES_intf)::get(this, "", "AES_vif", AES_vif)) begin
                `uvm_error("AES_AGENT", "Virtual interface not found in config DB")
            end else begin
                `uvm_info("AES_AGENT", "Virtual interface found and set in config DB", UVM_LOW)
            end

            uvm_config_db#(virtual AES_intf)::set(this, "monitor", "AES_vif", AES_vif);
            uvm_config_db#(virtual AES_intf)::set(this, "driver", "AES_vif", AES_vif);

        endfunction


        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            driver.seq_item_port.connect(sequencer.seq_item_export);
            monitor.ap.connect(ap);
        endfunction
    endclass : AES_agent

endpackage : AES_agent_pkg