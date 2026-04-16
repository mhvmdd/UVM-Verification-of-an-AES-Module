package AES_scoreboard_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import AES_transaction_pkg::*;

    class AES_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(AES_scoreboard)

        integer fd;
        logic [127:0] exp_out;

        uvm_analysis_imp #(AES_seq_item,AES_scoreboard) imp;

        function new(string name = "AES_scoreboard", uvm_component parent = null);
            super.new(name, parent);

        endfunction

        function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            imp = new("imp", this);
        endfunction


        
        function void write (AES_seq_item t);
        
                if (t.valid_out ) begin
                    // $display("Received transaction in scoreboard: %s", t.display());
                    
                    // NOTE: MAKE SURE THE PATH TO CODE AND FILES ARE RIGHT 
                    // TIP : RUN THE PYTHON CODE ON TERMINAL FROM THE DIRECTORY 
                    //       OF THE UVM SCOREBOARD TO CHECK NO ERRORS

                    // Open file "key.txt" for writing

                    fd = $fopen("key.txt","w");
                    if (fd == 0) begin
                        `uvm_error("AES_scoreboard", "Failed to open key.txt for writing")
                        return;
                    end

                    // Writing to file : First line writing the data , Second line writing the key

                    $fdisplay(fd,"%h \n%h",t.plain_text , t.cipher_key);

                    // Close the "key.txt"

                    $fclose(fd);

                    if (t.enc_dec) begin
                        // "$system" task to run the python code and ensure correct working directory
                        if ($system("python  ../Python_code/aes_enc.py") != 0) begin
                            `uvm_error("AES_scoreboard", "Python encryption script failed")
                            return;
                        end

                        // Open file "output.txt" for reading

                        // fd = $fopen("enc_out.txt","r");
                    end
                    else begin
                        // "$system" task to run the python code and ensure correct working directory
                        if ($system("python  ../Python_code/aes_dec.py") != 0) begin
                            `uvm_error("AES_scoreboard", "Python decryption script failed")
                            return;
                        end

                        // Open file "output.txt" for reading

                    end
                    fd = $fopen("output.txt","r");
                    if (fd == 0) begin
                        `uvm_error("AES_scoreboard", "Failed to open output.txt for reading")
                        return;
                    end

                    // Reading the output of python code through "output.txt" file

                    $fscanf(fd,"%h",exp_out);

                    // Close the "output.txt"

                    $fclose(fd);

                    // COMPARE THE ACTUAL OUTPUT AND EXPECTED OUTPUT

                    if(exp_out == t.cipher_text)
                        $display("SUCCESS , OUT IS %h and EXP OUT IS %h ", t.cipher_text , exp_out);
                    else 
                        $display("FAILURE , OUT IS %h and EXP OUT IS %h ", t.cipher_text , exp_out);  

                end
        endfunction
    endclass : AES_scoreboard

endpackage : AES_scoreboard_pkg
