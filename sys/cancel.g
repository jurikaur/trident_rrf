M591 D0
M220 S100 ; restore speed to 100%
M221 S100 ; restore extrusion flow to 100%

M106 P0 S0 ; layer fan off
G1 E2 F3600 ; unretract previous amount before ramming
G1 E5 F400
G1 E-5 F3600

G1 E-50 F600 ; retract filament from hotend 50mm with 10mm/min

G1 X150 Y200 Z250 ; park nozzle X150 Y100 to allow next sensorless homing to have some speed for stall detection

G10 P0 S-273.1 R-273.1 ; turn off T0 toolhead
M144 ; bed standby
M140 S-273.1 ; turn off bed heater
G92 E0 ; reset extrusion position

M84 ; stop all motors
M141 S-273.1 ; turn off chamber heater
M98 P"0:/macros/Chamber led/led-off" ; turn off chamber leds
M98 P"0:/macros/Bed Fans/Bed Fan OFF" ; turn off bed fans

;echo >>"job-history.csv" global.cancel_statistics

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"