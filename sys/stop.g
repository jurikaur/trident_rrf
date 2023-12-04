; stop.g  v1.0
; Called when M0 (Stop) is run, when a print file completes normally or is cancelled.

; For E3D Revo Micro

; SuperSlicer outputs G10/retract before this macro get's called!
echo "stop.g start"

set global.RunDaemon = true                                                    ; Enable daemon.g after printing because of bug in RRF 3.5.0b1+

M400                                                                           ; Wait for moves to finish
G91                                                                            ; Relative positioning
M83                                                                            ; Extruder relative positioning
G10                                                                            ; Retraction
G1 Z1.00 X20.0 Y20.0 F20000                                                    ; Short quick move to disengage from print
G1 Z10.00 F20000                                                               ; Move Z-Axis 10mm away from part
G90                                                                            ; Absolute positioning
G1 X150 Y290 F9000                                                             ; Move gantry close to home
M98 P"/sys/lib/print/tip_shaping.g"                                            ; Extrude slightly to help form a nice tip
G1 E{-(global.unload_length)} F800                                             ; Retract filament from meltzone
M400                                                                           ; Wait for moves to finish
M140 S0                                                                        ; Turn off heated bed
G10 P0 R0 S0                                                                   ; Set active and standby temps for T0 to 0°C
M107                                                                           ; Turn off the print cooling fan
M702                                                                           ; Unload filament
M84                                                                            ; Disable steppers
M42 P0 S0                                                                      ; Turn off chamber lights
M106 P2 S0                                                                     ; Turn off bed fans

; log successful printing
var extrusion = 0
while #job.file.filament > 0
  if iterations + 1 > #job.file.filament
    break
  set var.extrusion = var.extrusion + job.file.filament[iterations]

echo >>"job-history.csv" """" ^ job.lastFileName ^ """," ^ state.time ^ "," ^ job.lastDuration ^ ",1," ^ var.extrusion

echo "stop.g end"