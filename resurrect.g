; File "0:/gcodes/Xol Extruder Mount - G2SA - TAP-Voron RRF(0.4mm)-ABS(Black) - Polymaker.gcode" resume print after print paused at 2023-12-01 21:40
G21
M140 P0 S105.0
G29 S1
G92 X143.489 Y182.924 Z13.850
G60 S1
G10 P0 S260 R260
T0 P0
M98 P"resurrect-prologue.g"
M116
M290 X0.000 Y0.000 Z0.000 R0
T-1 P0
T0 P6
; Workplace coordinates
G10 L2 P1 X0.00 Y0.00 Z0.00
G10 L2 P2 X0.00 Y0.00 Z0.00
G10 L2 P3 X0.00 Y0.00 Z0.00
G10 L2 P4 X0.00 Y0.00 Z0.00
G10 L2 P5 X0.00 Y0.00 Z0.00
G10 L2 P6 X0.00 Y0.00 Z0.00
G10 L2 P7 X0.00 Y0.00 Z0.00
G10 L2 P8 X0.00 Y0.00 Z0.00
G10 L2 P9 X0.00 Y0.00 Z0.00
G54
M106 S0.45
M106 P0 S0.45
M106 P2 S0.50
M116
G92 E0.00000
M83
G94
M486 S0 A"Voron_Design_Cube_v8.STL id:1 copy 0"
M486 S1 A"Xol Extruder Mount - G2SA - TAP.stl id:0 copy 0"
M486 S1
G17
M23 "0:/gcodes/Xol Extruder Mount - G2SA - TAP-Voron RRF(0.4mm)-ABS(Black) - Polymaker.gcode"
M26 S5601725
G0 F6000 Z15.850
G0 F6000 X143.489 Y182.924
G0 F6000 Z13.850
G1 F18000.0 P0
G21
M24
