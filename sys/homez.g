G1 X150 Y150 ; move probe position
M913 Z50 ;lower motor current to 50%

; do rough home
M98 P"0:/sys/rough-homez.g"

;touch probe
M558 A2 H3:3 R0.75 ;set dive 3mm and probe recovery time
G31 Z3 Y0 Z-24.5 ; set probe offset
M558.2 S20 R144315 ; set touch probe drive current
M558.3 S1 F200 V1.0 ; set touch parameters
G1 Z3 ; move to rough Z=3mm
G4 P100 ; wait
G30 ; touch
M558.3 s0 ; set standard mode
M558.2 K0 S16 R136744 ; set standard SZP calibration data
M558 H10 ; turn on dive
G1 Z20 ; go to Z=20

M913 Z100 ;set motor current back to 100%