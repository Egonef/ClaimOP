extends StaticBody2D

var clicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Left-click"):
		if (get_local_mouse_position().x > -30 and get_local_mouse_position().x < 30 and get_local_mouse_position().y < 40 and get_local_mouse_position().y > -40):
				position = get_global_mouse_position()
	


