extends Area2D

var manoxposition = position.x

var vectorPosiciones = [manoxposition, manoxposition + 50]
var possize = vectorPosiciones.size()
signal ordenar_Cartas(vectorPosiciones, possize)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ordenar_Cartas.emit(vectorPosiciones, possize)
	possize = vectorPosiciones.size()
