extends Node2D

# class member variables go here, for example:
# get_node("res://scenes/scene_weapon_manager.tscn")
# get_node("res://scripts/script_weapons.gd")
var PLAYER_SPEED = 10
var player_node

#Set this in the inherited child
var playerTypesArr = [0, 1, 2]
var playerType

onready var weaponManagerInstance = preload("res://scenes/scene_weapon_manager.tscn")
var maxPlayerAmmo
var currentPlayerAmmo
var maxMagAmmo
var currentMagAmmo
var ammoPickupAmount

var fireRate
var damage

func _ready():	
	set_process(true)
	#weaponStats = preload('')
	
	setPlayerType(playerType)


func _process(delta):
	var direction_vert = Vector2(0,0)
	var direction_hor = Vector2(0,0)
	
	if Input.is_action_pressed("move_up"):
		direction_vert = Vector2(0,-1)
	elif Input.is_action_pressed("move_down"):
		direction_vert = Vector2(0,1)
	
	if Input.is_action_pressed("move_right"):
		direction_hor = Vector2(1,0)
	elif Input.is_action_pressed("move_left"):
		direction_hor = Vector2(-1,0)
		
	var direction = (direction_vert + direction_hor).normalized()
	self.translate(direction* PLAYER_SPEED)
	
	if Input.is_action_pressed("reload"):
		reload()

#	get_node('Sprite').set_pos(player_pos)
# - player_pos.x, mouse_y - player_pos.y)

# to be called in the specific player class
func getPlayerType(type):
	playerType = playerTypesArr[type]
	
func setPlayerType(type):
	var weaponStats = weaponManagerInstance.instance()
	weaponStats.getWeapon(type)
	
	maxMagAmmo = weaponStats.weaponParamArr[0]
	maxPlayerAmmo = weaponStats.weaponParamArr[1]
	fireRate = weaponStats.weaponParamArr[2]
	damage = weaponStats.weaponParamArr[3]
	ammoPickupAmount = weaponStats.weaponParamArr[4]
	
func setHealth():
	if (currentHealth < maxHealth):
		if(currentHealth + 25 > maxHealth):
			currentHealth = maxHealth
		else:
			currentHealth += 25

func setAmmo():
	if(currentPlayerAmmo < maxPlayerAmmo):
		if(currentPlayerAmmo + 10 > maxPlayerAmmo):
			currentPlayerAmmo = maxPlayerAmmo
		else:
			currentAmmo += 10

func reload():
	var reloadedAmmo = maxMagAmmo - currentMagAmmo
	#if you have bullets that can be added
	if(currentMagAmmo < maxMagAmmo):
		#if the bullets you need to reload is less than how many you have, reload fully and take out however many bullets u used
		if(reloadedAmmo <= currentPlayerAmmo):
			currentMagAmmo = maxMagAmmo
			currentPlayerAmmo -= reloadedAmmo
		#if you dont have enough bullets but you have more than 0 bullets in your stash, you reload however many you have and ur stash = 0
		elif(currentPlayerAmmo != 0):
			currentMagAmmo += currentPlayerAmmo
			currentPlayerAmmo = 0
	#NEEDS RELOAD PAUSE
	
	
	
	
	
	
	
	
	
	
	
	
	
	