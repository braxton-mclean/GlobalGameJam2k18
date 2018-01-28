extends Node2D

# class member variables go here, for example:
enum weapon_list{AR, SNIPER, PISTOL}

var weapons_front_sprite = [ar_front, sniper_front, pistol_front, etc_front]
var weapons_back_sprite = [ar_back, sniper_back, pistol_back, etc_back]



#TODO NEEDS TO FIND THE PROPER FILE OF THE WEAPON sprite
var ar_front = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var sniper_front = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var pistol_front = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var etc_front = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

var ar_back = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var sniper_back = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var pistol_back = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var etc_back = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

var weapon_type = weapon_list.PISTOL
var bullet_type
var max_mag_ammo
var max_stash_ammo
var curr_mag_ammo
var curr_stash_ammo
var fire_rate
var base_damage
var ammo_drop_amount
var bullet_speed

#var ar = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var sniper = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var pistol = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var etc = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

func _enter_tree():
	if(weapon_type == weapon_list.AR):
		set_weapon_params(30, 180, .12, 25, 30, 15)
		bullet_type = preload('res://scenes/ammo/scene_metal_bullet.tscn')
	if(weapon_type == weapon_list.SNIPER):
		set_weapon_params(5, 30, 1, 100, 7, 0)
		bullet_type = preload('res://scenes/ammo/scene_blue_ball.tscn')
	if(weapon_type == weapon_list.PISTOL):
		set_weapon_params(10, 80, .5, 10, 15, 15)
		bullet_type = preload('res://scenes/ammo/scene_metal_bullet.tscn')

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func reload():
	pass
	
func pickup_ammo():
	var amount_left = ammo_drop_amount
	amount_left = amount_left - (max_mag_ammo - curr_mag_ammo)
	curr_mag_ammo = max_mag_ammo
	curr_stash_ammo = curr_stash_ammo + amount_left
	if (curr_stash_ammo > max_stash_ammo):
		curr_stash_ammo = max_stash_ammo

func set_weapon(WEAPON_ENUM):
	weapon_type = WEAPON_ENUM

func set_weapon_params(mag_ammo, stash_ammo, fire_rate, damage, ammo_drop, bullet_speed):
	self.max_mag_ammo = mag_ammo
	self.curr_mag_ammo = mag_ammo
	self.max_stash_ammo = stash_ammo
	self.curr_stash_ammo = stash_ammo
	self.fire_rate = fire_rate
	self.base_damage = damage
	self.ammo_drop_amount =ammo_drop
	self.bullet_speed = bullet_speed