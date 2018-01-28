extends Control
#reference to master scene
var game_info_ref
var game_info_instance
#reference to UI button of players(individual)
onready var hacker_node = get_node("MarginContainer/VerticalContainer/CharSelection/HackerContainer/Hacker")
onready var sniper_node = get_node("MarginContainer/VerticalContainer/CharSelection/SniperContainer/Sniper")
onready var infantry_node = get_node("MarginContainer/VerticalContainer/CharSelection/InfantryContainer/Infantry")
#reference to UI button of levels(individual)
onready var level_1_node = get_node("MarginContainer/VerticalContainer/LevelSelection/Level 1 Container/Level 1")
onready var level_2_node = get_node("MarginContainer/VerticalContainer/LevelSelection/Level 2 Container/Level 2")
onready var level_3_node = get_node("MarginContainer/VerticalContainer/LevelSelection/Level 3 Container/Level 3")
#reference to all the UI characters or ui levels
onready var char_selection = get_node("MarginContainer/VerticalContainer/CharSelection")
onready var level_selection = get_node("MarginContainer/VerticalContainer/LevelSelection")

#reference to the ACTUAL levels
onready var level_1_name = preload("res://scenes/level_1.tscn")
#onready var level_2_name = preload("res://scenes/level_2.tscn")
#onready var level_3_name = preload("res://scenes/level_3.tscn")

var level_names = [level_1_name]#, level_2_name, level_3_name]

var char_num

func _ready():
	# Called every time the node is added to the scene.
	game_info_ref = preload("res://scenes/master_scene.tscn")
	game_info_instance = game_info_ref.instance()
	

#The next three functions say that that particular player cannot be chosen again. After the button is pressed, it toggles the UI so you can select a level
func _on_hacker_pressed():
	game_info_instance.b_can_pick_character[0] = false
	level_selection_visibility_toggle()
	char_num = 0

	print ('hacker pressed') # replace with function body

func _on_sniper_pressed():
	game_info_instance.b_can_pick_character[1] = false
	level_selection_visibility_toggle()
	char_num = 1
	
	print ('sniper pressed') # replace with function body

func _on_infantry_pressed():
	game_info_instance.b_can_pick_character[2] = false
	level_selection_visibility_toggle()
	char_num = 2

	print ('infantry pressed') # replace with function body


#next three functions allow you to select a ui level. like before, sets that level so you cant pick it again. hides the ui, sets the level num in the master scene and sets the character number
func _on_level_1_pressed():
	game_info_instance.b_can_pick_level[0] = false
	hide_UI()
	game_info_instance.level_num = 0
	game_info_instance.load_level(char_num)
	
func _on_level_2_pressed():
	game_info_instance.b_can_pick_level[1] = false
	hide_UI()
	game_info_instance.level_num = 1
	game_info_instance.load_level(char_num)

func _on_level_3_pressed():
	game_info_instance.b_can_pick_level[2] = false
	hide_UI()
	game_info_instance.level_num = 2
	game_info_instance.load_level(char_num)


func level_selection_visibility_toggle():
	char_selection.hide()
	level_selection.show()
	
	if(game_info_instance.b_can_pick_level[0] == false):
		level_1_node.hide()
	if(game_info_instance.b_can_pick_level[1] == false):
		level_2_node.hide()
	if(game_info_instance.b_can_pick_level[2] == false):
		level_3_node.hide()

func char_selection_visibility_toggle():
	char_selection.show()
	level_selection.hide()
	
	if(game_info_instance.b_can_pick_character[0] == false):
		hacker_node.hide()
	if(game_info_instance.b_can_pick_character[1] == false):
		sniper_node.hide()
	if(game_info_instance.b_can_pick_character[2] == false):
		infantry_node.hide()

func hide_UI():
	var ui = get_node(".")
	ui.hide()

