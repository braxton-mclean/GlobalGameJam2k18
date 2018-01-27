extends Node2D

# class member variables go here, for example:
enum weaponList{ar, sniper, pistol, etc}

var weaponsFrontSprite = [arFront, sniperFront, pistolFront, etcFront]
var weaponsBackSprite = [arBack, sniperBack, pistolBack, etcBack]

var weapon
var numOfWeapon

#TODO NEEDS TO FIND THE PROPER FILE OF THE WEAPON sprite
var arFront = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var sniperFront = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var pistolFront = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var etcFront = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

var arBack = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var sniperBack = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var pistolBack = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
var etcBack = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

var maxMagAmmo1
var maxStashAmmo1
var maxMagAmmo
var fireRate
var damage
#MAY NOT NEED
#var healthDrop
var ammoDrop
var weaponParamArr = [maxAmmo, currentAmmo, fireRate, damage]
#var ar = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var sniper = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var pistol = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")
#var etc = load("res://sources/images/sprite_blue_ball/sprite_big_blue1.png")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	setWeaponParams()
	pass

func getWeapon(weaponID):
	numOfWeapon = weaponID

func setWeaponParams():
	if(weaponList.ar == numOfWeapon):
		maxMagAmmo = 30
		maxStashAmmo = 180
		fireRate = .5
		damage = 25
		ammoDrop = 30
	elif(weaponList.sniper == numOfWeapon):
		maxMagAmmo = 5
		maxStashAmmo = 30
		fireRate = .05
		damage = 100
		ammoDrop = 7
	elif(weaponList.pistol == numOfWeapon):
		maxMagAmmo = 10
		maxStashAmmo = 80
		fireRate = .2
		damage = 10
		ammoDrop = 15
	elif(weaponList.etc == numOfWeapon):
		maxMagAmmo = 0
		maxStashAmmo = 0
		fireRate = 0
		damage = 0
		ammoDrop = 0
	
	weaponParamArr = [maxAmmo, currentAmmo, fireRate, damage, ammoDrop]
	
