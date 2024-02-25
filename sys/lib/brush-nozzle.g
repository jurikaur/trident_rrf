G90
if !exists(param.S) || param.S == 0
  G1 Y290 F18000 ; avoid hitting the probe dock
  G1 X220 F18000
  G1 Y305 F18000

G1 Z2 F2400 ; Z2 to actually brush, anything much higher for testing
G1 X260 F5000
G1 X220 Y303 F5000
G1 X260 F5000
G1 X220 Y305 F5000
G1 Z10 F2400