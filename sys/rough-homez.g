M308 A"SZP coil" S10 Y"thermistor" P"120.temp0" ; thermistor on SZP coil
M558 P11 C"120.i2c.ldc1612" F36000 T36000    ; configure SZP as probe 1, type 11, on CAN address 120
M558.2 K0 S15 R136467
G31 K0 Z3 P9095
G1 X150 Y150                    ; move to probe point

;G91                             ; Relative mode
;G1 H2 Z5 F5000                    ; Lower the bed
;G90                                ; back to absolute positioning

G30 K0