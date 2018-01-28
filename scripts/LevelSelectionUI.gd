extends Control

onready var hacker_node = get_node("MarginContainer/VerticalContainer/CharSelection/HackerContainer/Hacker")
onready var sniper_node = get_node("MarginContainer/VerticalContainer/CharSelection/SniperContainer/Sniper")
onready var infantry_node = get_node("MarginContainer/VerticalContainer/CharSelection/InfantryContainer/Infantry")
onready var level_1_node = get_node("MarginContainer/VerticalContainer/LevelSelection/Level 1 Container/Level 1")
onready var level_2_node = get_node("MarginContainer/VerticalContainer/LevelSelection/Level 2 Container/Level 2")
onready var level_3_node = get_node("MarginContainer/VerticalContainer/LevelSelection/Level 3 Container/Level 3")
onready var char_selection = get_node("MarginContainer/VerticalContainer/CharSelection")
onready var level_selection = get_node("MarginContainer/VerticalContainer/LevelSelection")

func _ready():
	# Called every time the node is added to the scene.
	if(b_can_choose_character[0] == false):
		hacker_node.hide()
	if(b_can_choose_character[1] == false):
		sniper_node.hide()
	if(b_can_choose_character[2] == false):
		infantry_node.hide()
		

func level_selection_visibility_toggle():
	char_selection.hide()
	level_selection.show()
	if(b_can_choose_level[0] == false):
		level_1_node.hide()
	if(b_can_choose_level[1] == false):
		level_2_node.hide()
	if(b_can_choose_level[2] == false):
		level_3_node.hide()

func _on_hacker_pressed():
	b_can_choose_character[0] = false
	hacker_node.hide()
	level_selection_visibility_toggle()
	print ('hacker pressed') # replace with function body

func _on_sniper_pressed():
	b_can_choose_character[1] = false
	sniper_node.hide()
	level_selection_visibility_toggle()
	print ('sniper pressed') # replace with function body

func _on_infantry_pressed():
	b_can_choose_character[2] = false
	infantry_node.hide()
	level_selection_visibility_toggle()
	print ('infantry pressed') # replace with function body

func _on_level_1_pressed():
	b_can_choose_level[0] = false
	level_1_node.hide()
	get_tree().change_scene("res://scenes/level_1.tscn")
	
func _on_level_2_pressed():
	b_can_choose_level[0] = false
	level_2_node.hide()
	get_tree().change_scene("res://scenes/LevelSelectionUI.tscn")

func _on_level_3_pressed():
	b_can_choose_level[0] = false
	level_3_node.hide()
	get_tree().change_scene("res://scenes/level_1.tscn")

func _on_char_selection_hide():
	pass # replace with function body

func _on_level_selection_draw():
	pass # replace with function body

