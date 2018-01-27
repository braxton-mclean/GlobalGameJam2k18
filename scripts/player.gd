extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var PLAYER_SPEED = 10
export var BULLET_OFFSET = 30
export var BULLET_SPEED = 5
var weapon
#Should be primary
var bullet
#should be secondary
var orb
# Used to calculate fire rate
var delta_sum = 0
var weapon_swap_cooldown = 0
func _ready():	
	#need an array or something to keep track of all the different bullet types and where the sprites are
	bullet = preload('res://scenes/bullet.tscn') 
	orb = preload('res://scenes/scene_projectile.tscn')
	#bullet speed should also be taken right here from the weapons manager
	weapon = orb
	set_process(true)

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_pos()
	var player_pos = self.get_pos()

	
	delta_sum = delta_sum + delta
	weapon_swap_cooldown = weapon_swap_cooldown + delta
#	print(weapon_swap_cooldown)
	_move()
	
	_shoot(player_pos, mouse_pos)
	_swap_weapon()
#	get_node('Sprite').set_pos(player_pos)

	if delta_sum > 100:
		delta_sum = 1
	if weapon_swap_cooldown > 100:
		weapon_swap_cooldown = 1

func _move():
	var direction_vert = Vector2(0,0)
	var direction_hor = Vector2(0,0)
	
	if Input.is_action_pressed("move_up"):
		direction_vert = Vector2(0, -1)
	elif Input.is_action_pressed("move_down"):
		direction_vert = Vector2(0, 1)
		
	if Input.is_action_pressed("move_right"):
		direction_hor = Vector2(1, 0)
	elif Input.is_action_pressed("move_left"):
		direction_hor = Vector2(-1, 0)
	
	var direction = (direction_vert + direction_hor).normalized()
	self.translate(direction * PLAYER_SPEED)
	
func _swap_weapon():
	if Input.is_action_pressed("right_click"):
		if weapon_swap_cooldown > 0.2:
			
			if weapon != orb:
				weapon = orb
			else:
				weapon = bullet
			weapon_swap_cooldown = 0
		
func _shoot(player_position, mouse_position):
	if Input.is_action_pressed("left_click"):
		var projectile = weapon.instance()		
		if delta_sum > projectile._get_fire_rate():
			var direction = mouse_position - player_position
			projectile.set_pos(player_position + direction.normalized() * BULLET_OFFSET)
			projectile.look_at(mouse_position)

			projectile._set_direction(direction.normalized() * BULLET_SPEED)
			get_parent().add_child(projectile)
			delta_sum = 0