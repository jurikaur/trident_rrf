var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  echo "Please home printer before cleaning the nozzle"
  M99

if heat.heaters[1].current < 190
  echo "Not cleaning a cold nozzle"
  M99

G1 Z{var.probe_height} F2400

M98 P"lib/purge-bucket.g"

G0 E10 F150

M98 P"lib/filament-ram.g"

G4 S2

M98 P"lib/brush-nozzle.g" S0
M98 P"lib/brush-nozzle.g" S1
G1 Z{var.probe_height} F2400
G1 Y302 F7000