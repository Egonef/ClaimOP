extends Node

var luminosity = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	luminosity = luminosity + 0.01
	if ( luminosity > 3):
		self.color = Color(97,23,12)
	self.energy = luminosity
