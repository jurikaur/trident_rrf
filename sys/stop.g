var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

M400
G91 ; relative positioning
G1 Z{var.probe_height} F2400 ; move nozzle relative to position
G90 ; absolute positioning

M106 P1 S0 ; layer fan off
M220 S100 ; reset speed factor to 100%
M221 D0 S100 ; reset extruder factor to 100%

G1 E-2 F3600 ; retract 2mm

G1 E2 F3600 ; unretract previous amount before ramming
G1 E1 F400  ; unretract 1mm
M400 ; wait for moves to finish

G10 P0 S-273.1 R-273.1 ; turn off T0 toolhead
M144 ; bed standby
M140 S-273.1 ; turn off bed heater
G92 E0 ; reset extrusion position

;G4 P300000 ; let nozzle cool for 5 minutes
;M98 P"Nozzle-clean.g" ; brush nozzle last time

G1 X150 Y200 Z250 ; park nozzle X150 Y100 to allow next sensorless homing to have some speed for stall detection

M84 ; stop all motors
M141 S-273.1 ; turn off chamber heater
M98 P"0:/macros/Chamber led/led-off" ; turn off chamber leds
M98 P"0:/macros/Bed Fans/Bed Fan OFF" ; turn off bed fans

; log successful printing
var extrusion = 0
while #job.file.filament > 0
  if iterations + 1 > #job.file.filament
    break
  set var.extrusion = var.extrusion + job.file.filament[iterations]

echo >>"job-history.csv" """" ^ job.lastFileName ^ """," ^ state.time ^ "," ^ job.lastDuration ^ ",1," ^ var.extrusion

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"

; start Chamber ventilate
if move.extruders[0].filament = "ABS" || move.extruders[0].filament = "ASA" || move.extruders[0].filament = "PC"
  set global.ventilateChamber = 30 ; set exhaust timer to 15min

; enable daemon
set global.RunDaemon = true