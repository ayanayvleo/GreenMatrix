open_project "C:/Users/ayana/GreenChip/build/runs/Leonard_Ayana_GreenMatrix/Leonard_Ayana_GreenMatrix.xpr"

set hook_file "C:/Users/ayana/GreenMatrix/constraints/allow_unconstrained_bitstream.tcl"

set_property STEPS.WRITE_BITSTREAM.TCL.PRE $hook_file [get_runs impl_1]

save_project

reset_run impl_1 -from_step write_bitstream

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

puts "IMPLEMENTATION STATUS: [get_property STATUS [get_runs impl_1]]"
puts "BITSTREAM PROGRESS: [get_property PROGRESS [get_runs impl_1]]"

close_project
exit
