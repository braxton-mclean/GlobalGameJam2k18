extends Area2D

# class member variables go here, for example:
var method = "setMeLater"
onready var animation = get_node("AnimationPlayer")
export var animationName = "enter name"

var type =["health", "ammo"]
var typeNum = 0

var healthTexture = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var ammoTexture = load("res://sources/images/sprite_red_ball/sprite_red_ball1.png")
var differentSprites = [healthTexture, ammoTexture]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("Sprite").set_texture(differentSprites[typeNum])
	pass

func _on_Pickup_area_enter( area ):
	if(area.has_method(method)):
		area.method()
		_destroy()

func _on_Pickup_body_enter( body ):
	if(body.has_method(method)):
		body.method()
		_destroy()
		
func _destroy():
	animation.play(animationName)
	queue_free()
	
#Call this method in the player class
func setMethod(typeOfPickup):
	method = typeOfPickup
#Call this method when spawning in order to determine the type of drop
func setType( num ):
	typeNum = num
