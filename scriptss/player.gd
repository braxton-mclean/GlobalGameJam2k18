extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var PLAYER_SPEED = 10
var player_node

func _ready():	
	set_process(true)

func _process(delta):
	var direction_vert = Vector2(0,0)
	var direction_hor = Vector2(0,0)
	
	if Input.is_action_pressed("move_up"):
		direction_vert = Vector2(0,-1)
	elif Input.is_action_pressed("move_down"):
		direction_vert = Vector2(0,1)
	
	if Input.is_action_pressed("move_right"):
		direction_hor = Vector2(1,0)
	elif Input.is_action_pressed("move_left"):
		direction_hor = Vector2(-1,0)
		
	var direction = (direction_vert + direction_hor).normalized()
	self.translate(direction* PLAYER_SPEED)

#	get_node('Sprite').set_pos(player_pos)
# - player_pos.x, mouse_y - player_pos.y)
