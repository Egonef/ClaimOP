extends StaticBody2D

var clicked = false
var xlock = true
var ypos = 599
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Left-click"):
		xlock = false
		if (get_local_mouse_position().x > -40 and get_local_mouse_position().x < 40 and get_local_mouse_position().y < 40 and get_local_mouse_position().y > -40):
				position = get_global_mouse_position()
				scale.x = 1.2
				scale.y = 1.2
	else:
		
		position.y = ypos
		scale.x = 1
		scale.y = 1
	




func _on_zona_mano_ordenar_cartas(posiciones , possize):
	print("Señal de posicion recibida")
	if (xlock == true):
		for n in possize:
			if (position.x != posiciones[n]):
				position.x = posiciones[n]
			
