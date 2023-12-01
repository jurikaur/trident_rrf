; usage M98 P"/sys/lib/print/heatsoak.g" T40

var chamber_temp = param.T

M106 P2 S0.40

while sensors.analog[9].lastReading < {var.chamber_temp} 
	M291 P"Waiting for chamber to pre-heat to 40" R"Pre-Heat Macro" S1 T5
	echo "Chamber", sensors.analog[9].lastReading
	G4 S5

M400
M106 P2 S0.50