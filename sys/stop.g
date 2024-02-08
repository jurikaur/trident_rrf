M400
G91 ; relative positioning
G1 Z5 F2400 ; move nozzle relative to position
G90 ; absolute positioning

M106 P0 S0 ; layer fan off
M220 S100 ; reset speed factor to 100%
M221 D0 S100 ; reset extruder factor to 100%

G1 E-2 F3600 ; retract 2mm

M98 P"/sys/lib/purge-bucket.g" ; move to purge bucket position


G1 E2 F3600 ; unretract previous amount before ramming
G1 E1 F400  ; unretract 1mm
G1 E-15 F3600 ; retract 15mm to clear meltzone
M400 ; wait for moves to finish

G10 P0 S-273.1 R-273.1 ; turn off T0 toolhead
M144 ; bed standby
M140 S-273.1 ; turn off bed heater
G92 E0 ; reset extrusion position
M84 ; stop all motors
M141 S-273.1 ; turn off chamber heater
M42 P0 S0
M106 P2 S0

; log successful printing
var extrusion = 0
while #job.file.filament > 0
  if iterations + 1 > #job.file.filament
    break
  set var.extrusion = var.extrusion + job.file.filament[iterations]

echo >>"job-history.csv" """" ^ job.lastFileName ^ """," ^ state.time ^ "," ^ job.lastDuration ^ ",1," ^ var.extrusion

echo "stop.g end"