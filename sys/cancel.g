M591 D0
M220 S100 ; restore speed to 100%
M221 S100 ; restore extrusion flow to 100%

M106 P0 S0 ; layer fan off
G1 E2 F3600 ; unretract previous amount before ramming
G1 E5 F400
G1 E-5 F3600

G1 X150 Y200 ; park nozzle X150 Y100 to allow next sensorless homing to have some speed for stall detection

echo >>"job-history.csv" global.cancel_statistics


; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"