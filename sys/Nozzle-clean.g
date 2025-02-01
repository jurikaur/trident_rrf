var thisMacroHeatOn = false
var probe_height = 25

if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

if tools[0].active[0] < {global.nozzleProbeTemperature}         ; check if the heater is powered and up to temp
    M568 P0 S{global.nozzleProbeTemperature} A2                 ; if cold set the nozzle temperature to 175 degrees
    M116 P0                                                     ; wait for the nozzle to reach temperature
    set var.thisMacroHeatOn = true                              ; set variable to show this macro set the temp
if heat.heaters[1].current < tools[0].active[0]
    M116 P0
G90                                                             ; make sure the printer is set to absolute
G1 Y290 F7000                                                   ; avoid hitting the probe dock
G1 X220 F7000
G1 Y302 F7000

G1 Z2 F3000                                                     ; lower z
G1 X260 F10000                                                  ; clean the nozzle
G1 X220 F10000                                                  ; clean the nozzle
G1 X260 F10000                                                  ; clean the nozzle
G1 X220 F10000                                                  ; clean the nozzle
G1 X260 F10000                                                  ; clean the nozzle
G1 X220 F10000                                                  ; clean the nozzle
G1 Z{var.probe_height} F6000                                    ; lift the nozzle
if var.thisMacroHeatOn = true                                   ; check if the heater temperature was set by this macro
    M568 P0 S0 A0                                               ; turn the hotend off