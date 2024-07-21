G91           ; move to relative mode
G1 E2 F800    ; extrude slightly 
G1 E-18 F800  ; retract filament from meltzone
G4 S2         ; dwell 2 seconds
G1 E-10 F800  ; retract filament into thermal break