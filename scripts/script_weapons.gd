extends Node2D

# class member variables go here, for example:
enum weaponList{ar, sniper, pistol, etc}

var weaponsFrontSprite = [arFront, sniperFront, pistolFront, etcFront]
var weaponsBackSprite = [arBack, sniperBack, pistolBack, etcBack]

var weapon
var numOfWeapon

var arFront = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var sniperFront = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var pistolFront = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var etcFront = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

var arBack = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var sniperBack = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var pistolBack = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var etcBack = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

var maxAmmo
var currentAmmo
var fireRate
var damage
#var ar = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var sniper = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var pistol = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var etc = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	setWeaponParams()
	pass
	
	
func setWeaponParams():
	if(weaponList.ar == numOfWeapon):
		maxAmmo = 30
		currentAmmo = 30
		fireRate = .5
		damage = 25
	elif(weaponList.sniper == numOfWeapon):
		maxAmmo = 5
		currentAmmo = 5
		fireRate = .05
		damage = 100
	elif(weaponList.pistol == numOfWeapon):
		maxAmmo = 10
		currentAmmo = 10
		fireRate = .2
		damage = 10
	elif(weaponList.etc == numOfWeapon):
		maxAmmo = 0
		currentAmmo = 0
		fireRate = 0
		damage = 0
	
	
func getWeapon(weaponID):
	numOfWeapon = weaponID