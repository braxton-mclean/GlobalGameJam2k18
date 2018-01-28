extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var list_of_used_room_buffs = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func activate_buffs(room_num, list_of_transmission_buffs):
	if(not room_num in list_of_used_room_buffs):
		for buff in list_of_transmission_buffs:
			print(buff)
			if(buff == "SNIPER"):
				var group_string = "room_" + str(room_num)
				var enemies = get_tree().get_nodes_in_group(group_string)
				if enemies.size() > 0:
					enemies[0].destroy()
					list_of_used_room_buffs.append(room_num)
