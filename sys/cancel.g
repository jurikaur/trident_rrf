;Retract the filament
G92 E1
G1 E-50 F900

;Move nozzle fast\n
G1 X150 Y200 F15000\n
;Move Bed Down\n
G1 Z250 F6000\n

;set machine to idle
M106 P1 S0 ; layer fan off
M220 S100 ; reset speed factor to 100%
M221 S100 ; reset extruder factor to 100%
M104 S0; turn off T0 toolhead
M144 ; bed standby
M140 S0 ; turn off bed heater
M141 S0; turn off chamber heater
M106 P4 S0 ; stop chamber heater fans manually
M84 ; stop all motors

M98 P"0:/macros/Chamber led/led-off" ; turn off chamber leds
M98 P"0:/macros/Bed Fans/Bed Fan OFF" ; turn off bed fans
