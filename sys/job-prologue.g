M98 R1

M42 P0 S0.6 ; turn chamber LED to 60%

G21 ;metric values
G90 ;absolute positioning
M83 ;relative extrusion
M107 ;start with the fan off
G92 E0 ;zero the extruded length

M140 S{param.H} ; start preheating the bed

M190 S{param.H} ; wait for bed to heat up
M116 H0

; heating chamber if bed temp is more than 90C
if {param.H} > 90
  if sensors.analog[2].lastReading < {param.C} ; check chamber thermistor value
    M141 S{param.C} ; turn on fake chamber heater to soak cahmber
    M106 P2 S0.60 ; turn on bed fans to heat chamber
    M116 H2 ; wait chamber to reach min requested temp
  M106 P2 S0.60 ; set bed fans to 50% to heat chamber
  M106 P3 C"EXHAUSTF" S0 B0.1 H2 T60 ; set exhaust fan to trigger on max chamber temp


; home printer
var need_g32 = false

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  set var.need_g32 = true
  G28
  if result != 0
    abort "Homing failed"
else
  G28 Z
  if result != 0
    abort "Homing failed"

; Z-Tilt bed
if var.need_g32
  M402 ; detach block
  M98 P"lib/brush-nozzle.g"
  M401 ; attach block

  G32
  if result != 0
    abort "Z-Tilt failed"

G10 P0 S{param.T} R50 ; start preheat hotend_0 can be later because rapido heats so rapidly

; bedmesh
if var.need_g32
  G29
M402

if result != 0
  abort "Mesh failed"

M116 P0

M98 P"lib/clean-nozzle.g"

; intro line
G1 X297 Y150 Z1 F12000
G1      Y50 Z{param.L} E30 F500 ;intro line
G92 E0 ;zero the extruded length again

M141 S-273.1 ; turn off fake chamber heater

M42 P0 S0.4 ; turn chamber LED to 40%