extends Area2D


var vectorPosiciones = [{"xposition": position.x,"ocupado": false,}, {"xposition": position.x,"ocupado": false,}]
var possize = vectorPosiciones.size()


func _ready():
	for n in possize:
		vectorPosiciones[n].xposition = vectorPosiciones[n].xposition + (100*n)
		print(vectorPosiciones[n].xposition)
	print(vectorPosiciones[0].xposition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Actualizo el tamaño del vector en caso de que se creen cartas nuevas
	possize = vectorPosiciones.size()
	
