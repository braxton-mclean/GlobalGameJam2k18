extends Node2D

# class member variables go here, for example:

enum style_enum{TRACE, PROJ}
export var BASE_SPEED = 50
onready var bullet_sprite = get_node("AnimatedSprite")
export var style = style_enum.PROJ
var direction
var damage
export var death_animation_name = "enter name"

# Reference to this projectile's owner
var projectile_owner

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



func _on_projectile_area_enter( area ):
	# Hit an enemy or asteroid
	if (area.has_method("projectile_collide")):#included in the enemy
		# Duck typing at it's best
		area.projectile_collide()
  print ("hit area2d")

func _on_projectile_body_enter(body):
	# Hit the tilemap
	print(body)
	if (projectile_owner == body):
		pass
	else:
		if (body.has_method('take_damage')):
			body.take_damage(self.damage)
		if(style != style_enum.TRACE):
			destroy()

func destroy():
	#add animation
	set_fixed_process(false)	
	queue_free()
	
func _on_timer_timeout():
	destroy()

func set_direction(vector):
	direction = vector

func set_speed( desired_velocity ):
	BASE_SPEED = desired_velocity

func set_damage(new_damage):
	self.damage = new_damage
  
func set_new_owner(new_owner):
	projectile_owner = new_owner

func _on_animatedsprite_finished():
	destroy()
	pass # replace with function body
