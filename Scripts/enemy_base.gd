exten6ds Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var player

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	player = get_node("room").player
	pass
