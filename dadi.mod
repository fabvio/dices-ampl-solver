### INSIEMI

set NODES ;
set DICES ;
set WORDS ;

# Ricavo gli archi del set di incompatibilità esaminando, per ogni parola, i casi in cui due lettere compaiono insieme
set I_ARCHES := setof { i in NODES, j in NODES: i<>j and exists {p in WORDS} ( match(p,i)<>0 and match(p,j)<>0) } (i,j);

### PARAMETRI

param FACES >= 0, default 6, integer;

### VARIABILI

var x{NODES cross DICES} binary;

### VINCOLI

subject to size{z in DICES}:
	sum{i in NODES} x[i,z] = FACES;

subject to unique{i in NODES}:
	sum{z in DICES} x[i,z] = 1;

subject to clique{(i,j) in I_ARCHES, z in DICES}:
	(x[i,z] + x[j,z]) <= 1;

### OBIETTIVO

# La funzione è massimizzata quando tutti gli elementi all'interno della matrice x sono posizionati all'interno di una cricca
maximize value:
	sum{i in NODES, z in DICES} x[i,z];
