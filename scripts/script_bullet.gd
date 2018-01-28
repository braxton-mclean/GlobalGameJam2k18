extends Node2D

# class member variables go here, for example:

export var BASE_SPEED = 50
onready var bullet_sprite = get_node("AnimatedSprite")
var direction
var damage
export var death_animation_name = "enter name"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization 
	set_fixed_process(true) #maybe weird?
	get_node("AnimatedSprite").set_frame(0)
	get_node("AnimatedSprite").play("default")
	pass
	
func _fixed_process(delta):
	if(BASE_SPEED != 0 and direction != null):
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

func _on_projectile_body_enter( body ):
	# Hit the tilemap
	hit_something()

func destroy():
	#add animation
	queue_free()
	
func _on_timer_timeout():
	destroy()

func set_direction(vector):
	direction = vector

func set_speed( desired_velocity ):
	BASE_SPEED = desired_velocity

func set_damage(new_damage):
	self.damage = new_damage

func _on_animatedsprite_finished():
	destroy()
	pass # replace with function body
