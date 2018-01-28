extends Node2D

# class member variables go here, for example:
var level_manager
var level_manager_instance

var buff_manager
var buff_manager_instance

var game_info_ref
var game_info_instance

var used_char
var used_level

var player
var player_instance

func _ready():
#	level_manager = preload("res://scenes/level_selection_ui.tscn")
#	level_manager_instance = get_parent().get_child()
		
#	game_info_ref = preload("res://scenes/master_scene.tscn")
#	game_info_instance = get_parent().get_child('master_scene')
	
	player = preload("res://scenes/player_scene.tscn")
	player_instance = player.instance()
	
func _on_timer_timeout():
	success()

func success():
	
#	game_info_instance.set_used_character(level_manager_instance.char_num)
#	game_info_instance.set_used_level(level_manager_instance.level_num)
#	used_level = level_manager_instance.level_num
	#level_manager_instance.level_completed()
	#player_instance.finsished_play()
	level_manager_instance.char_selection_visibility_toggle()
#	self.set_hidden(true)
	level_manager_instance.set_hidden(false)
	get_tree().get_root().remove_child(self)

	
	#get player used
	#set buff to true in buff manager
	 #gets destroyed in the function

func set_used_char(used):
	used_char = used
	

