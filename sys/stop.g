M98 P"0:/macros/Chamber led/led-off" ; turn off chamber leds

; log successful printing
var extrusion = 0
while #job.file.filament > 0
  if iterations + 1 > #job.file.filament
    break
  set var.extrusion = var.extrusion + job.file.filament[iterations]

echo >>"job-history.csv" """" ^ job.file.fileName ^ """," ^ state.time ^ "," ^ job.warmUpDuration ^ "," ^ job.duration ^ ",1," ^ var.extrusion
