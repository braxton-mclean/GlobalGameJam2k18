extends Area2D

# class member variables go here, for example:

export var speed = 50
onready var animation = get_node("AnimationPlayer")
onready var bullet_sprite = get_node("AnimatedSprite")
var direction = Vector2(1, 1) # FOR THE CHARACTER 
export var deathAnimationName = "enter name"
export var continuousAnimationName = "enter name"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization 
	set_fixed_process(true)
	pass
	

func _fixed_process(delta):
	translate(direction*speed*delta)

func _hit_something():
	set_process(false)
	_destroy()

func _on_Projectile_area_enter( area ):
	# Hit an enemy or asteroid
	if (area.has_method("takedamage")):#included in the enemy
		# Duck typing at it's best
		area.takedamage()
		_hit_something()
	print ("hit area2d")


 # replace with function body

func _on_Projectile_body_enter( body ):
	# Hit the tilemap
	_hit_something()

func _destroy():
	#add animation

	queue_free()
	
func _on_Timer_timeout():
	queue_free()


func _set_direction(vector):
	direction = vector

func setSpeed( desiredVelocity ):
	speed = desiredVelocity


	
	
	
	
	









