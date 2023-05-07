set_global_assignment -entity "pll_2048" -library "lib_pll_2048" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll_2048" -library "lib_pll_2048" -name IP_TOOL_VERSION "21.1"
set_global_assignment -entity "pll_2048" -library "lib_pll_2048" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll_2048" -name SPD_FILE [file join $::quartus(sip_path) "pll_2048.spd"]

set_global_assignment -library "lib_pll_2048" -name MISC_FILE [file join $::quartus(sip_path) "pll_2048_sim/pll_2048.vo"]
