extends Node

var luminosidad = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	luminosidad = GlobalSignals.Luz_Up 
	if ( luminosidad > 3):
		self.color = Color(9,23,12)
	self.energy = luminosidad
	#print(self.energy)
