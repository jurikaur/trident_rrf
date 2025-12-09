var thisMacroHeatOn = false
if tools[0].active[0] < {global.nozzleProbeTemperature}         ; check if the heater is powered and up to temp
    M568 P0 S{global.nozzleProbeTemperature} A2                 ; if cold set the nozzle temperature to 175 degrees
    M116 P0                                                     ; wait for the nozzle to reach temperature
    set var.thisMacroHeatOn = true                              ; set variable to show this macro set the temp
if heat.heaters[1].current < tools[0].active[0]
    M116 P0

; Step 0: move to a safe probing position      
M564 H0                    ; unlock movement 
G90                        ; absolute positioning
G1 H0 X150 Y150 F10000     ; move probe to bed center
M913 Z75                   ; 75% Z motor current to reduce damage/intensity of impact 

; Step 1: do a rough contact-free measurement to get *kinda close* to bed
M98 P"szp_mode_normal.g"
M558 A1 F1200
; set a safe Z trigger height to trigger when the bed is coming close but safely not touching. omit XY, these were defined in config.g!
; Z and P values are important here: These relate "Probe value [P] of 8850 relates to [Z] offset of 6mm".
; Get your probe's P value by moving to Z=6 manually after calibrating as described in szp_mode_normal.g, and read the value reported in DWC then.
; if szp_mode_normal.g is modified, these values must be updated too!
G31 K0 Z6 P8964            
G30 K0 S1                 ; execute Z homing to ensure printhead is close to bed


; Step 2: we should now be ~6mm above the bed. TIme to do the fine tuning!
M98 P"szp_mode_touch.g"
M558 A10 F600
G30 K0 S1                  ; execute contact probing and set Z
G91                        ; relative positioning
G1 Z3                      ; move up a bit
G90                        ; absolute positioning

; FInalization
M564 H1                     ; re-lock movement 
M913 Z100                   ; reset Z motor current to 100%  

if var.thisMacroHeatOn = true                                   ; check if the heater temperature was set by this macro
    M568 P0 S0 A0                                               ; turn the hotend off