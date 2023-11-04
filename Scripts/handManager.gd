extends Area2D


var vectorPosiciones = []
var possize = vectorPosiciones.size()
var cont = 0



func _ready():
	GlobalSignals.locatespot.connect(on_locatespot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Actualizo el tamaño del vector en caso de que se creen cartas nuevas
	pass
	


func on_locatespot():
	possize = vectorPosiciones.size()
	if (cont < possize):
		if (cont == 0):
			vectorPosiciones[cont].xposition = vectorPosiciones[cont].xposition
			cont = cont + 1
		else:
			vectorPosiciones[cont].xposition = vectorPosiciones[cont-1].xposition + 65
			cont = cont + 1



