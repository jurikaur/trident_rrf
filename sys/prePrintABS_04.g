; /sys/lib/print/print_start.g
; Called when starting a print
; Used to configure print parameters

; usage M98 P"/sys/lib/print/print_start.g" B[first_layer_bed_temperature] E{first_layer_temperature[initial_extruder]} C[Chamber maintain temp] S[heatsoak time]
; define variables

var bed_temp = param.B
var hotend_temp = param.E
var filament = "ABS"
var chamber_temp = param.C
var soak_time = param.S
var first_layer_height = 0.25


M42 P0 S1                                                                      ; turn chamber lights 100%
G21                                                                            ; Set units to millimeters
G90                                                                            ; Use absolute coordinates
M83                                                                            ; Use relative distances for extrusion
M220 S100                                                                      ; Reset speed multiplier
M140 S{var.bed_temp}                                                           ; Set bed temperature
M116 H0 S1                                                                     ; Wait for the bed to reach its temperature +/-5�C
M98 P"/sys/lib/print/heatsoak.g" T40                                           ; Heating chamber to 40C                                                                    
G10 P0 R150 S150                                                               ; Set active and standby temps for the initial tool for probing
G28                                                                            ; home all axes
M401                                                                           ; attach klicky probe
G32                                                                            ; bed tramming
;G29 S2                                                                         ; disable bedmesh to allow IS to work
;G29 S1 P"/sys/heightmap.csv"                                                   ; Load height map file "full_heightmap.csv" and enable mesh bed compensation
;M376 H5                                                                        ; Set bed compensation taper to 5mm
;M593 P"zvdd" F38.3 S0.00 L0.25                                                 ; Enable IS
G10 P0 R{var.hotend_temp} S{var.hotend_temp}                                   ; Set active and standby temps for the initial tool
M42 P0 S0.3                                                                    ; Turn on chamber lights to 30%
T0                                                                             ; Select initial tool
M701 S{var.filament}                                                           ; Load filament
M703                                                                           ; Filament config
M106 P3 C"EXHAUSTF" S0 B0.1 H2 T{var.chamber_temp}                             ; Set Chamber temp to exhaust fan
G0 Z{(var.first_layer_height + 5)} F3000                                       ; Drop bed to first layer height + 5mm to reduce pucker factor
M116 H1                                                                        ; Wait hotend to reach it's temperature
M98 P"/sys/lib/print/print_purge.g"                                            ; Purge the nozzle before starting print
M400                                                                           ; Wait for moves to finish
