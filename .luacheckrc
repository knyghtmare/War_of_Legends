max_line_length=555
max_code_line_length=19484
-- show the warning/error codes as well
codes=true
-- skip showing files with no issues
quiet=1
-- skip showing undefined variable usage
-- there are thousands of warnings here because luacheck is unaware of Wesnoth's
-- lua environment and has no way to check which have been loaded
globals={"wesnoth","wml","gui","filesystem","unit_test","stringx","mathx","ai"}
allow_defined=false
allow_defined_top=true
-- skip showing unused variables
unused=false
-- skip showing warnings about shadowing upvalues and empty if branches
ignore={"111","112","113","131","412","421","422","431","542","582","611","612","614","621"}
