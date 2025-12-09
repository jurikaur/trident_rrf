var do_rough_home=false
if exists(global.z_probe_height)
  set var.do_rough_home = global.z_rough_home

if (var.do_rough_home=true)
  M308 A"SZP coil" S10 Y"thermistor" P"120.temp0" ; thermistor on SZP coil
  M558 P11 C"120.i2c.ldc1612" F300:120 T6000 S0.02 R0.75 A3 H3 ; turn off dive for two stage homing
  G31 Z3.55 P8225 ; probe to height Z~3
  G30 ; probe
  G1 Z10 ; lower bed 10mm

;if exists(global.z_rough_home)
;  set global.z_rough_home = true