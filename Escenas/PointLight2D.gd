extends PointLight2D


var Aumentar_Luz = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Aumentar_Luz = GlobalSignals.luminosity
		self.energy = var Aumentar_Luz + 0.12
