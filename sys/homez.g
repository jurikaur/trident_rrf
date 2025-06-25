var thisMacroHeatOn = false
if tools[0].active[0] < {global.nozzleProbeTemperature}         ; check if the heater is powered and up to temp
    M568 P0 S{global.nozzleProbeTemperature} A2                 ; if cold set the nozzle temperature to 175 degrees
    M116 P0                                                     ; wait for the nozzle to reach temperature
    set var.thisMacroHeatOn = true                              ; set variable to show this macro set the temp
if heat.heaters[1].current < tools[0].active[0]
    M116 P0

G1 X150 Y150 F3000 ; move probe position
M913 Z50 ;lower motor current to 50%

M98 P"szp_mode_normal.g" ; SZP to normal mode
; do rough home
M98 P"0:/sys/rough-homez.g"

;touch probe
M98 P"szp_mode_touch.g" ; SZP to touch mode
M558 A2 H3:3 R0.75 ;set dive 3mm and probe recovery time
G1 Z3 ; move to rough Z=3mm
G4 P100 ; wait
G30 ; touch
M558 H10 ; turn on dive
G1 Z20 ; go to Z=20

M98 P"szp_mode_normal.g" ; SZP to normal mode

M913 Z100 ;set motor current back to 100%

if var.thisMacroHeatOn = true                                   ; check if the heater temperature was set by this macro
    M568 P0 S0 A0                                               ; turn the hotend off