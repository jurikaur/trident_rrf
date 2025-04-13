var do_rough_home=false
if exists(global.z_probe_height)
  set var.do_rough_home = global.z_rough_home

if (var.do_rough_home=true)
  M558 A1 H3 ; turn off dive for two stage homing
  M558.2 S15 R136467 ; set standard drive current
  M558.3 S0 ; set standard mode
  G31 Z3 P9111 ; probe to height Z~3
  G30 ; probe
  G1 Z10 ; lower bed 10mm

;if exists(global.z_rough_home)
;  set global.z_rough_home = true