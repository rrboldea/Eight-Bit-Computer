project_new eightbitcomp -overwrite
set_global_assignment -name FAMILY MAX10
set_global_assignment -name DEVICE 10M50DAF484C7G

set_global_assignment -name VERILOG_FILE synchronizer.v
set_global_assignment -name VERILOG_FILE pos_edge.v

set_global_assignment -name VERILOG_FILE mux_sel1b.v
set_global_assignment -name VERILOG_FILE conditional_mux.v
set_global_assignment -name VERILOG_FILE register.v
set_global_assignment -name VERILOG_FILE shiftRegister.v
set_global_assignment -name VERILOG_FILE FAC.v
set_global_assignment -name VERILOG_FILE adder.v
set_global_assignment -name VERILOG_FILE counter.v

set_global_assignment -name VERILOG_FILE ALU.v
set_global_assignment -name VERILOG_FILE "clock.v"
set_global_assignment -name VERILOG_FILE control_unit.v

######## DECIMAL DISPLAY ########
set_global_assignment -name VERILOG_FILE absoluteValue.v
set_global_assignment -name VERILOG_FILE dabble.v
set_global_assignment -name VERILOG_FILE doubleDabble.v
set_global_assignment -name VERILOG_FILE segment7DecimalDecoder.v
set_global_assignment -name VERILOG_FILE decimalDisplay.v

######## SDRAM ########
set_global_assignment -name VERILOG_FILE sdram_write.v
set_global_assignment -name VERILOG_FILE sdram_read.v
set_global_assignment -name VERILOG_FILE sdram_initialize.v
set_global_assignment -name VERILOG_FILE sdram_controller.v
set_global_assignment -name VERILOG_FILE sdram.v

######## SDRAM PROGRAM ########
set_global_assignment -name VERILOG_FILE sdram_input.v

#set_global_assignment -name VERILOG_FILE sdram_input_test.v

set_global_assignment -name VERILOG_FILE eightbitcomp.v

set_global_assignment -name TOP_LEVEL_ENTITY eightbitcomp

#============================================================
# CLOCK
#============================================================
set_location_assignment PIN_P11 -to clk

#============================================================
# SDRAM
#============================================================
set_location_assignment PIN_U17 -to DRAM_ADDR[0]
set_location_assignment PIN_W19 -to DRAM_ADDR[1]
set_location_assignment PIN_V18 -to DRAM_ADDR[2]
set_location_assignment PIN_U18 -to DRAM_ADDR[3]
set_location_assignment PIN_U19 -to DRAM_ADDR[4]
set_location_assignment PIN_T18 -to DRAM_ADDR[5]
set_location_assignment PIN_T19 -to DRAM_ADDR[6]
set_location_assignment PIN_R18 -to DRAM_ADDR[7]
set_location_assignment PIN_P18 -to DRAM_ADDR[8]
set_location_assignment PIN_P19 -to DRAM_ADDR[9]
set_location_assignment PIN_T20 -to DRAM_ADDR[10]
set_location_assignment PIN_P20 -to DRAM_ADDR[11]
set_location_assignment PIN_R20 -to DRAM_ADDR[12]
set_location_assignment PIN_T21 -to DRAM_BA[0]
set_location_assignment PIN_T22 -to DRAM_BA[1]
set_location_assignment PIN_U21 -to DRAM_CAS_N
set_location_assignment PIN_N22 -to DRAM_CKE
set_location_assignment PIN_L14 -to DRAM_CLK
set_location_assignment PIN_U20 -to DRAM_CS_N
set_location_assignment PIN_Y21 -to DRAM_DQ[0]
set_location_assignment PIN_Y20 -to DRAM_DQ[1]
set_location_assignment PIN_AA22 -to DRAM_DQ[2]
set_location_assignment PIN_AA21 -to DRAM_DQ[3]
set_location_assignment PIN_Y22 -to DRAM_DQ[4]
set_location_assignment PIN_W22 -to DRAM_DQ[5]
set_location_assignment PIN_W20 -to DRAM_DQ[6]
set_location_assignment PIN_V21 -to DRAM_DQ[7]
set_location_assignment PIN_P21 -to DRAM_DQ[8]
set_location_assignment PIN_J22 -to DRAM_DQ[9]
set_location_assignment PIN_H21 -to DRAM_DQ[10]
set_location_assignment PIN_H22 -to DRAM_DQ[11]
set_location_assignment PIN_G22 -to DRAM_DQ[12]
set_location_assignment PIN_G20 -to DRAM_DQ[13]
set_location_assignment PIN_G19 -to DRAM_DQ[14]
set_location_assignment PIN_F22 -to DRAM_DQ[15]
set_location_assignment PIN_V22 -to DRAM_LDQM
set_location_assignment PIN_U22 -to DRAM_RAS_N
set_location_assignment PIN_J21 -to DRAM_UDQM
set_location_assignment PIN_V20 -to DRAM_WE_N

#============================================================
# KEY
#============================================================
#set_location_assignment PIN_B8 -to push_b
#set_location_assignment PIN_A7 -to pop_b

set_location_assignment PIN_B8 -to sdram_load_b
set_location_assignment PIN_A7 -to rst_b

#============================================================
# LED
#============================================================
set_location_assignment PIN_A8 -to led[0]
set_location_assignment PIN_A9 -to led[1]
set_location_assignment PIN_A10 -to led[2]
set_location_assignment PIN_B10 -to led[3]
set_location_assignment PIN_D13 -to led[4]
set_location_assignment PIN_C13 -to led[5]
set_location_assignment PIN_E14 -to led[6]
set_location_assignment PIN_D14 -to led[7]
#set_location_assignment PIN_A11 -to data_out[8]
#set_location_assignment PIN_B11 -to data_out[9]

#set_location_assignment PIN_A8 -to sdram_read_data[0]
#set_location_assignment PIN_A9 -to sdram_read_data[1]
#set_location_assignment PIN_A10 -to sdram_read_data[2]
#set_location_assignment PIN_B10 -to sdram_read_data[3]
#set_location_assignment PIN_D13 -to sdram_read_data[4]
#set_location_assignment PIN_C13 -to sdram_read_data[5]
#set_location_assignment PIN_E14 -to sdram_read_data[6]
#set_location_assignment PIN_D14 -to sdram_read_data[7]


#============================================================
# DECIMAL DISPLAY
#============================================================
set_location_assignment PIN_C14 -to dec0[0]
set_location_assignment PIN_E15 -to dec0[1]
set_location_assignment PIN_C15 -to dec0[2]
set_location_assignment PIN_C16 -to dec0[3]
set_location_assignment PIN_E16 -to dec0[4]
set_location_assignment PIN_D17 -to dec0[5]
set_location_assignment PIN_C17 -to dec0[6]

set_location_assignment PIN_C18 -to dec1[0]
set_location_assignment PIN_D18 -to dec1[1]
set_location_assignment PIN_E18 -to dec1[2]
set_location_assignment PIN_B16 -to dec1[3]
set_location_assignment PIN_A17 -to dec1[4]
set_location_assignment PIN_A18 -to dec1[5]
set_location_assignment PIN_B17 -to dec1[6]

set_location_assignment PIN_B20 -to dec2[0]
set_location_assignment PIN_A20 -to dec2[1]
set_location_assignment PIN_B19 -to dec2[2]
set_location_assignment PIN_A21 -to dec2[3]
set_location_assignment PIN_B21 -to dec2[4]
set_location_assignment PIN_C22 -to dec2[5]
set_location_assignment PIN_B22 -to dec2[6]

set_location_assignment PIN_E17 -to sign

#============================================================
# SW
#============================================================
#set_location_assignment PIN_C10 -to data_in[0]
#set_location_assignment PIN_C11 -to data_in[1]
#set_location_assignment PIN_D12 -to data_in[2]
#set_location_assignment PIN_C12 -to data_in[3]
#set_location_assignment PIN_A12 -to data_in[4]
#set_location_assignment PIN_B12 -to data_in[5]
#set_location_assignment PIN_A13 -to data_in[6]
#set_location_assignment PIN_A14 -to data_in[7]

set_location_assignment PIN_C10 -to write_data[0]
set_location_assignment PIN_C11 -to write_data[1]
set_location_assignment PIN_D12 -to write_data[2]
set_location_assignment PIN_C12 -to write_data[3]
set_location_assignment PIN_A12 -to write_data[4]
set_location_assignment PIN_B12 -to write_data[5]
set_location_assignment PIN_A13 -to write_data[6]
set_location_assignment PIN_A14 -to write_data[7]

set_location_assignment PIN_B14 -to show_addr_bus

set_location_assignment PIN_F15 -to prog




load_package flow
execute_flow -compile
project_close
