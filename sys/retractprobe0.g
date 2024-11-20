var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height  

if sensors.probes[0].value[0] == 0
  M564 H1
  G90
  ;G1 X52 Y285 F3000
  G1 X50 Y285 F6000
  G1 Y307
  G1 X95
  M400 S1
  if sensors.probes[0].value[0] == 0
    abort "Probe detach failed"
G1 X150 Y150 Z{var.probe_height}