extends Node2D

# class member variables go here, for example:
enum weapon_list{AR, SNIPER, PISTOL, ROBOT}
enum bullet_styles{TRACE, PROJ}

var ar_node = preload("res://sources/animations/item/assault_rifle/assault_rifle.tres")
var sniper_node = preload("res://sources/animations/item/laser_gun/laser_gun.tres")
var pistol_node = preload("res://sources/animations/item/pistol/pistol.tres")

var weapon_type = weapon_list.PISTOL
var animation_to_play

var bullet_style
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
		set_weapon_params(30, 180, .5, 25, 30, 300, bullet_styles.PROJ)
		bullet_type = preload('res://scenes/ammo/scene_metal_bullet.tscn')
	if(weapon_type == weapon_list.SNIPER):
		set_weapon_params(5, 30, 1, 100, 7, 0, bullet_styles.TRACE)
		bullet_type = preload('res://scenes/ammo/scene_laser_burst.tscn')
	if(weapon_type == weapon_list.PISTOL):
		set_weapon_params(10, 80, 1, 10, 15, 200, bullet_styles.PROJ)
		bullet_type = preload('res://scenes/ammo/scene_metal_bullet.tscn')
	if(weapon_type == weapon_list.ROBOT):
		set_weapon_params(5, 30, 1, 10, 7, 200)
		bullet_type = preload('res://scenes/ammo/scene_blue_ball.tscn')

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("AnimatedSprite").set_sprite_frames(animation_to_play)
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
	
func set_weapon_rotation(direction):
	var initial_dir = self.get_rotd()
	self.look_at(get_parent().get_pos() + direction)
	if(self.get_rotd() > 360):
		self.set_rotd(self.get_rotd() - 360)
	elif(self.get_rotd() < -360):
		self.set_rotd(self.get_rotd() + 360)
	
	if(self.get_rotd() > 180 or (self.get_rotd() < 0 and self.get_rotd() > -180)):
		self.get_node("AnimatedSprite").set_flip_v(true)
	else:
		self.get_node("AnimatedSprite").set_flip_v(false)
	pass

func set_weapon_params(mag_ammo, stash_ammo, fire_rate, damage, ammo_drop, bullet_speed, bullet_style):
	self.max_mag_ammo = mag_ammo
	self.curr_mag_ammo = mag_ammo
	self.max_stash_ammo = stash_ammo
	self.curr_stash_ammo = stash_ammo
	self.fire_rate = fire_rate
	self.base_damage = damage
	self.ammo_drop_amount = ammo_drop
	self.bullet_speed = bullet_speed
	self.bullet_style = bullet_style
