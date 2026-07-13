open_project "C:/Users/ayana/GreenChip/build/runs/Leonard_Ayana_GreenMatrix/Leonard_Ayana_GreenMatrix.xpr"

open_run impl_1

set_property SEVERITY Warning [get_drc_checks NSTD-1]
set_property SEVERITY Warning [get_drc_checks UCIO-1]

write_bitstream -force "C:/Users/ayana/GreenMatrix/GreenMatrix.bit"

exit
