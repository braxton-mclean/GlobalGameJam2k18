extends Node2D

# class member variables go here, for example:
enum weapon_list{ar, sniper, pistol}

var weapons_front_sprite = [ar_front, sniper_front, pistol_front, etc_front]
var weapons_back_sprite = [ar_back, sniper_back, pistol_back, etc_back]

var weapon

#TODO NEEDS TO FIND THE PROPER FILE OF THE WEAPON sprite
var ar_front = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var sniper_front = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var pistol_front = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var etc_front = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

var ar_back = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var sniper_back = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var pistol_back = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var etc_back = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

var max_mag_ammo
var max_stash_ammo
var fire_rate
var base_damage
#MAY NOT NEED
#var healthDrop
var ammo_drop
var weapon_param_arr = [max_ammo, current_ammo, fire_rate, damage]
#var ar = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var sniper = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var pistol = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var etc = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_weapon_params()
	pass

func get_weapon(weapon_id):
	num_of_weapon = weapon_id

func set_weapon_params():
	if(weapon_list.ar == num_of_weapon):
		max_mag_ammo = 30
		max_stash_ammo = 180
		fire_rate = .5
		damage = 25
		ammo_drop = 30
	elif(weapon_list.sniper == num_of_weapon):
		max_mag_ammo = 5
		max_stash_ammo = 30
		fire_rate = .05
		damage = 100
		ammo_drop = 7
	elif(weapon_list.pistol == num_of_weapon):
		max_mag_ammo = 10
		max_stash_ammo = 80
		fire_rate = .2
		damage = 10
		ammo_drop = 15
	elif(weapon_list.etc == num_of_weapon):
		max_mag_ammo = 0
		max_stash_ammo = 0
		fire_rate = 0
		damage = 0
		ammo_drop = 0
	
	weapon_param_arr = [max_mag_ammo, current_ammo, fire_rate, damage, ammo_drop]
	
