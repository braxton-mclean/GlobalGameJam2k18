extends Node2D

# class member variables go here, for example:

export var BASE_SPEED = 50
onready var bullet_sprite = get_node("AnimatedSprite")
var direction;
export var death_animation_name = "enter name"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization 
	set_fixed_process(true) #maybe weird?
	pass
	
func _fixed_process(delta):
	translate(direction*BASE_SPEED*delta)

func hit_something():
	set_fixed_process(false)
	destroy()

func _on_projectile_area_enter( area ):
	# Hit an enemy or asteroid
	if (area.has_method("projectile_collide")):#included in the enemy
		# Duck typing at it's best
		area.projectile_collide()
		hit_something()
	print ("hit area2d")

func _on_projectile_body_enter( body ):
	# Hit the tilemap
	print("body hit something")
	hit_something()

func destroy():
	#add animation
	queue_free()
	
func _on_timer_timeout():
	queue_free()

func set_direction(vector):
	direction = vector

func set_speed( desired_velocity ):
	BASE_SPEED = desired_velocity


	
	
	
	
	









