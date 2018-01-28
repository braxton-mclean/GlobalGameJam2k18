extends Node2D

var level_ui
var ui_instance

var player
var player_instance
#hacker = 0, sniper = 1, infantry = 2
var b_can_pick_character = [true, true, true]
var b_can_pick_level = [true, true, true]

var main_menu

var class_type



func _ready():
	level_ui = preload("res://scenes/level_selection_ui.tscn")
	ui_instance = level_ui.instance()
	
	player = preload("res://scenes/scene_player.tscn")
	player_instance = player.instance()
	
	#CREATE MAIN MENU
		#MENU(PLAY) SHOULD ENABLE THE LEVELSELECTIONUI


func finish_level():
	ui_instance.char_selection_visibility_toggle()




#func new_level(level_num):
#	set_level_param_defaults()
#	if(level_num == 0):
#		set_level_specific_param(level_num)
#	if(level_num == 1):
#		set_level_specific_param(level_num)
#	if(level_num == 2):
#		set_level_specific_param(level_num)
#
#func set_level_specific_param(level_num):
#	if(level_num == 0):
#		level_names = ["res://scenes/level_1_1.tscn", "res://scenes/level_1_2.tscn", "res://scenes/level_1_3.tscn"]
#		level_sprites = []
#	if(level_num == 1):
#		level_names = ["res://scenes/level_2_1.tscn", "res://scenes/level_2_2.tscn", "res://scenes/level_2_3.tscn"]
#		level_sprites = []
#	if(level_num == 2):
#		level_names = ["res://scenes/level_3_1.tscn", "res://scenes/level_3_2.tscn", "res://scenes/level_3_3.tscn"]
#		level_sprites = []


#FUNC NEWLEVEL( LEVEL NUMBER )
	#SETS ALL LEVELSELECTIONUI PARAMS TO DEFAULTS
	#IF LEVELNUM == 0
		#LEVEL0()(SETTING THE SPRITES FOR LEVEL/SETLEVEL)
	#IF LEVELNUM == 1
		#ETC

#