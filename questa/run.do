vlib work

vlog ../AES_Encrypt_only/*.v -Epretty AES_Encrypt_Files.v +cover -covercells
vlog ../AES_Decrypt_only/*.v -Epretty AES_Decrypt_Files.v +cover -covercells
vlog ../UVM/*.sv -Epretty +cover -covercells

vsim -voptargs=+acc work.AES_top -cover -classdebug -uvmcontrol=all +UVM_VERBOSITY=UVM_HIGH

run 0

add wave /AES_top/aes_wrapper/*

add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/env/agent/monitor/seq_item

coverage save AES_Top.ucdb -onexit -du work.AES_Encrypt

run -all

quit -sim

vcover report AES_Top.ucdb -details -annotate -all -output AES_Encrypt_Coverage.txt

