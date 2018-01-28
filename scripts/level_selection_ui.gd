extends Control
#reference to master scene
var game_info_ref
var game_info_instance
#reference to UI button of players(individual)
onready var hacker_node = get_node("MarginContainer/VerticalContainer/CharSelection/HackerContainer/Hacker")
onready var sniper_node = get_node("MarginContainer/VerticalContainer/CharSelection/SniperContainer/Sniper")
onready var infantry_node = get_node("MarginContainer/VerticalContainer/CharSelection/InfantryContainer/Infantry")
#reference to UI button of levels(individual)
onready var level_1_node = get_node("MainUI/MarginContainer/VerticalContainer/LevelSelection/Level 1 Container")
onready var level_2_node = get_node("MainUI/MarginContainer/VerticalContainer/LevelSelection/Level 2 Container")
onready var level_3_node = get_node("MainUI/MarginContainer/VerticalContainer/LevelSelection/Level 3 Container")
#reference to all the UI characters or ui levels
onready var char_selection = get_node("MarginContainer/VerticalContainer/CharSelection")
onready var level_selection = get_node("MarginContainer/VerticalContainer/LevelSelection")
onready var title_image = get_node("MainUI/MarginContainer/VerticalContainer/LevelTitle")

#reference to the ACTUAL levels
onready var level_1_name = preload("res://scenes/level_1_1.tscn")
var level_1_instance
onready var level_2_name = preload("res://scenes/level_2_1.tscn")
var level_2_instance
#onready var level_3_name = preload("res://scenes/level_3.tscn")
var level_3_instance
var level_list

var player
var player_instance
var player_types

var if_used_char = [false, false, false]
var if_used_level = [false, false, false]

var char_num

var level_num

func _ready():
	# Called every time the node is added to the scene.
	
	game_info_ref = preload("res://scenes/master_scene.tscn")
	game_info_instance = game_info_ref.instance()
	
	level_1_instance = level_1_name.instance()
	level_1_instance.game_info_instance = game_info_instance
	level_1_instance.level_manager_instance = self
	
	level_2_instance = level_2_name.instance()
	level_2_instance.game_info_instance = game_info_instance
	level_2_instance.level_manager_instance = self
	
	print("adding")
	var buff_manager = preload("res://scenes/buff_manager_scene.tscn")
	var buff_manager_instance = buff_manager.instance()
	get_tree().get_root().call_deferred("add_child", buff_manager_instance)
	print("added")
	
	level_list = [level_1_instance, level_2_instance]#, level_2_name, level_3_name]
	
	player = preload("res://scenes/player_scene.tscn")
	player_instance = player.instance()
	player_types = [player_instance.player_type_enum.HACKER, player_instance.player_type_enum.SNIPER, player_instance.player_type_enum.INFANTRY]

#The next three functions say that that particular player cannot be chosen again. After the button is pressed, it toggles the UI so you can select a level
func _on_hacker_pressed():
	if(if_used_char[0] == false):
		char_select(0)
	else:
		print ("please fuck urself sir")
	print ('hacker pressed') # replace with function body

func _on_sniper_pressed():
	if(if_used_char[1] == false):
		char_select(1)
	else:
		print('fuck urself too')
	print ('sniper pressed') # replace with function body

func _on_infantry_pressed():
	if(if_used_char[2] == false):	
		char_select(2)
	else:
		print('rip u dude')
	print ('infantry pressed') # replace with function body


#next three functions allow you to select a ui level. like before, sets that level so you cant pick it again. hides the ui, sets the level num in the master scene and sets the character number
func _on_level_1_pressed():
	level_select(0)
	print ('level 1 loaded') 
	
func _on_level_2_pressed():
	level_select(1)

func _on_level_3_pressed():
	level_select(2)

func char_select(num):
	char_num = num	
	game_info_instance.b_can_pick_character[num] = false
	print('lmao')
	level_selection_visibility_toggle()
	player_instance.player_type = player_types[num]
	print (game_info_instance.b_can_pick_character[num])

func level_select(num):
	level_num = num	
	game_info_instance.b_can_pick_level[num] = false
	hide_UI()
	get_tree().get_root().add_child(level_list[num])
	player_instance.set_pos(level_list[num].spawn_location)
	player_instance.set_name("player")
	level_list[num].add_child(player_instance)
	print (game_info_instance.b_can_pick_level[num])
	print ('level selected')
	
	


func level_selection_visibility_toggle():
	char_selection = get_node("MarginContainer/VerticalContainer/CharSelection")
	level_selection = get_node("MarginContainer/VerticalContainer/LevelSelection")
	char_selection.set_hidden(true)
	level_selection.set_hidden(false)
	
	if(game_info_instance.b_can_pick_level[0] == false):
		level_1_node.set_hidden(true)
	if(game_info_instance.b_can_pick_level[1] == false):
		level_2_node.set_hidden(true)
	if(game_info_instance.b_can_pick_level[2] == false):
		level_3_node.set_hidden(true)

func char_selection_visibility_toggle():
	char_selection = get_node("MarginContainer/VerticalContainer/CharSelection")
	level_selection = get_node("MarginContainer/VerticalContainer/LevelSelection")
	
	char_selection.set_hidden(false)
	level_selection.set_hidden(true)
	
	game_info_ref = preload("res://scenes/master_scene.tscn")
	game_info_instance = game_info_ref.instance()
	
	if(game_info_instance.b_can_pick_character[0] == false):
		hacker_node.hide()
	if(game_info_instance.b_can_pick_character[1] == false):
		sniper_node.hide()
	if(game_info_instance.b_can_pick_character[2] == false):
		infantry_node.hide()

func hide_UI():
	var ui = get_node(".")
	ui.set_hidden(true)

func level_completed():
	char_selection_visibility_toggle()




#func set_player_node_params():
#	var hacker_container = get_node("MarginContainer/VerticalContainer/CharSelection/HackerContainer")
#	var sniper_container = get_node("MarginContainer/VerticalContainer/CharSelection/SniperContainer")
#	var infantry_container = get_node("MarginContainer/VerticalContainer/CharSelection/InfantryContainer")
#
