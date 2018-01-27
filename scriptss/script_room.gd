extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var height_max = 20
export var width_max = 25
export var should_be_random = false
export var height_min = 10
export var width_min = 10
var room_height
var room_width
var room_walls
var room_contents

# called before any children nodes are added to this node, always occurs
func _enter_tree():
	if(should_be_random == true):
		randomize()
		room_height = randi() % height_max
		print(room_height)
		if(room_height < height_min):
			room_height = height_min
		room_width = randi() % width_max
		print(room_width)
		if(room_width < width_min):
			room_width = width_min
	else:
		room_height = 15
		room_width = 10
	pass

# called after all children have been added to this node, always occurs
func _ready():
	# Initialization here
	room_contents = []
	
	var room_wall_piece = preload("res://scenes/scene_wall_segment.tscn")
	var room_floor_piece = preload("res://scenes/scene_floor_segment.tscn")

	for x in range(room_width):
		room_contents.append([])
		for y in range(room_height):
			var node
			if((y % (room_height - 1)) == 0 or (x % (room_width - 1)) == 0):
				node = room_wall_piece.instance()
			else:
				node = room_floor_piece.instance()
			room_contents[x].append(node)
			# room_contents[x][y] = node
			add_child(node)
			var new_node_name = "room_piece_%d_%d"
			new_node_name = new_node_name % [x, y]
			node.set_name(new_node_name)
			var unit_size = node.get_texture().get_size().x
			node.set_pos(Vector2(x*unit_size, y*unit_size))
	pass
