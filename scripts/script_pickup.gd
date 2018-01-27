extends Area2D

# class member variables go here, for example:
var method = "setMeLater"
onready var animation = get_node("AnimationPlayer")
export var animationName = "enter name"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Pickup_area_enter( area ):
	if(area.hasmethod(method)):
		#area.method()
		pass
func _on_Pickup_body_enter( body ):
	if(body.hasmethod(method)):
		#body.method()
		pass
func _destroy():
	animation.play(animationName)
	queue_free()
	
