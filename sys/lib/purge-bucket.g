G90
var left_bucket = random(3) != 2 ; left bucket is 2x larger than right bucket

G1 Y290 F18000 ; avoid hitting the probe dock

if var.left_bucket
  G1 X200 F18000
else
  G1 X280 F18000

G1 Y305 F18000