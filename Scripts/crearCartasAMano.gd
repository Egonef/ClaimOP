extends Node2D

var cartaIns = preload("res://Escenas/carta.tscn")

var cont = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (cont < 13):
		cont += 1 # cont = cont + 1
		print("Contador: ", cont)
		add_child(cartaIns.instantiate())
