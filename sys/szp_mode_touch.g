; get the S and R values by calling M558.2 K1 S-1 in small Z distance. 2-5mm from bed worked fine for me.
M558.2 K0 S16 R137643     
; V=Threshold. Start with V0.1 and increase until it works reliably without misdetections.
M558.3 K0 S1 V0.9