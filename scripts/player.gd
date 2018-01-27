extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var PLAYER_SPEED = 10
export var BULLET_OFFSET = 30
export var BULLET_SPEED = 10
var bullet

# Used to calculate fire rate
var delta_sum = 0

func _ready():	
	bullet = preload('res://scenes/scene_projectile.tscn')
	set_process(true)

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_pos()
	var player_pos = self.get_pos()

	
	delta_sum = delta_sum + delta
	
	_move()
	
	_shoot(player_pos, mouse_pos)
#	get_node('Sprite').set_pos(player_pos)
# - player_pos.x, mouse_y - player_pos.y)

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
	
func _shoot(player_position, mouse_position):
	if Input.is_action_pressed("left_click"):
		if delta_sum > .5:
			var projectile = bullet.instance()
			var direction = mouse_position - player_position
			projectile.set_pos(player_position + direction.normalized() * BULLET_OFFSET)
			projectile._set_direction(direction.normalized() * BULLET_SPEED)
			get_parent().add_child(projectile)
			delta_sum = 0