var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

G90
if !exists(param.S) || param.S == 0
  G1 Y290 F7000 ; avoid hitting the probe dock
  G1 X220 F7000
  G1 Y302 F7000

G1 Z2 F2400 ; Z2 to actually brush, anything much higher for testing
G1 X260 F5000
G1 X220 Y302 F5000
G1 X260 F5000
G1 X220 Y304 F5000
G1 Z{var.probe_height} F2400