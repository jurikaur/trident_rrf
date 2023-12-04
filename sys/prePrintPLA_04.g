; /sys/lib/print/print_start.g
; Called when starting a print
; Used to configure print parameters

; usage M98 P"/sys/lib/print/print_start.g" B[first_layer_bed_temperature] E{first_layer_temperature[initial_extruder]} C[Chamber maintain temp] S[heatsoak time]
; define variables

var bed_temp = param.B
var hotend_temp = param.E
var filament = "PLA"
var chamber_temp = param.C
var soak_time = param.S


M42 P0 S1                                                                      ; turn chamber lights 100%
; M203 X18000.00 Y18000.00 Z900.00                                               ; set maximum speeds (mm/min)
; M201 X5000.00 Y3000.00 Z150.00                                                 ; set accelerations (mm/s^2)
G21                                                                            ; Set units to millimeters
G90                                                                            ; Use absolute coordinates
M83                                                                            ; Use relative distances for extrusion
M220 S100                                                                      ; Reset speed multiplier
M140 S{var.bed_temp}                                                           ; Set bed temperature
M116 H0 S1                                                                     ; Wait for the bed to reach its temperature +/-5�C
;M98 P"/sys/lib/print/heatsoak.g" T40                                           ; Heating chamber to 40C                                                                    
G10 P0 R150 S150                                                               ; Set active and standby temps for the initial tool for probing
M98 P"/sys/lib/print/print_prep.g"                                             ; Homes all axes and level the bed while everything is hot
;G28                                                                            ; home all axes
;G32                                                                            ; bed tramming
;G28 Z                                                                          ; home Z
G29 S1 P"/sys/heightmap.csv"                                                   ; Load height map file "full_heightmap.csv" and enable mesh bed compensation
M376 H5                                                                        ; Set bed compensation taper to 5mm
G10 P0 R{var.hotend_temp} S{var.hotend_temp}                                   ; Set active and standby temps for the initial tool
M42 P0 S0.3                                                                    ; Turn on chamber lights to 30%
T0                                                                             ; Select initial tool
M701 S{var.filament}                                                           ; Load filament
M703                                                                           ; Filament config
M106 P3 C"EXHAUSTF" S0 B0.1 H2 T{var.chamber_temp}                             ; Set Chamber temp to exhaust fan
;G0 Z{(global.first_layer_height + 5)} F3000                                    ; Drop bed to first layer height + 5mm to reduce pucker factor
G31 K0 P500 X0 Y0 Z-1.09                                                       ; set z-offset
M116 H1 S0                                                                     ; Wait hotend to reach it's temperature
M98 P"/sys/lib/print/print_purge.g"                                            ; Purge the nozzle before starting print
M400                                                                           ; Wait for moves to finish
