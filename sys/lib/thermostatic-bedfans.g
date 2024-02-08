if exists(param.S) && param.S == 0
  M106 P2 C"BEDF_12V" S0 H-1
else
  M106 P2 C"BEDF_12V" S0 L0.3 X0.6 B0.1 H0 T80:115
