extends KinematicBody2D

enum player_type_enum{HACKER, SNIPER, INFANTRY}
export var player_type = player_type_enum.INFANTRY
var weapon_pack

var PLAYER_SPEED = 200
export var BULLET_OFFSET = 30
var player_node
var weapon_1
var weapon_2
var active_weapon


# Used to calculate fire rate
var fire_rate_delta = 0
var weapon_swap_cooldown = 0
func _ready():
	setup_character(true)
	set_process(true)
	
func setup_character(should_reset):
	if (should_reset == true):
		weapon_pack = preload("res://scenes/scene_weapon.tscn")
		weapon_1 = weapon_pack.instance()
		weapon_2 = weapon_pack.instance()
		if(player_type == player_type_enum.HACKER):
			weapon_1.weapon_type = weapon_1.weapon_list.PISTOL
		elif(player_type == player_type_enum.SNIPER):
			weapon_1.weapon_type = weapon_1.weapon_list.SNIPER
			weapon_2.weapon_type = weapon_2.weapon_list.PISTOL
		elif(player_type == player_type_enum.INFANTRY):
			weapon_1.weapon_type = weapon_1.weapon_list.AR
			weapon_2.weapon_type = weapon_2.weapon_list.PISTOL
		self.add_child(weapon_1)
		if(weapon_2 != null):
			self.add_child(weapon_2)
		active_weapon = weapon_1

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_pos()
	var player_pos = self.get_pos()
	
	fire_rate_delta = fire_rate_delta + delta
	weapon_swap_cooldown = weapon_swap_cooldown + delta
	move_boi(delta)
	
	shoot(player_pos, mouse_pos)
	check_swap_weapon()

func configure_player():
	weapon_pack = preload("res://scenes/scene_weapon.tscn")
	weapon_1 = weapon_pack.instance()
	weapon_2 = weapon_pack.instance()
	var sprite = get_node(AnimatedSprite)
	if(player_type == player_type_enum.HACKER):
		weapon_1.weapon_type = weapon_1.weapon_list.PISTOL
	elif(player_type == player_type_enum.SNIPER):
		weapon_1.weapon_type = weapon_1.weapon_list.SNIPER
		weapon_2.weapon_type = weapon_2.weapon_list.PISTOL
	elif(player_type == player_type_enum.INFANTRY):
		weapon_1.weapon_type = weapon_1.weapon_list.AR
		weapon_2.weapon_type = weapon_2.weapon_list.PISTOL
	self.add_child(weapon_1)
	if(weapon_2 != null):
		self.add_child(weapon_2)
	active_weapon = weapon_1

func move_boi(delta):
	var direction_vert = Vector2(0,0)
	var direction_hor = Vector2(0,0)
	
	if Input.is_action_pressed("move_up"):
		direction_vert = Vector2(0, -1)
	elif Input.is_action_pressed("move_down"):
		direction_vert = Vector2(0, 1)
		
	if Input.is_action_pressed("move_right"):
		direction_hor = Vector2(1, 0)
	elif Input.is_action_pressed("move_left"):
		direction_hor = Vector2(-1, 0)
	
	var direction = (direction_vert + direction_hor).normalized()
	move((direction* PLAYER_SPEED * delta))

#	get_node('Sprite').set_pos(player_pos)
# - player_pos.x, mouse_y - player_pos.y)

# CHANGE
func get_player_type(type):
	#player_type = playerTypesArr[type]
	pass

#func health_pickup():
#	if (currentHealth < maxHealth):
#		if(currentHealth + 25 > maxHealth):
#			currentHealth = maxHealth
#		else:
#			currentHealth += 25

func ammo_pickup():
	active_weapon.pickup_ammo()

func reload():
	if Input.is_action_pressed("reload"):
		active_weapon.reload()
#		var reloadedAmmo = maxMagAmmo - currentMagAmmo
#		#if you have bullets that can be added
#		if(currentMagAmmo < maxMagAmmo):
#			#if the bullets you need to reload is less than how many you have, reload fully and take out however many bullets u used
#			if(reloadedAmmo <= currentPlayerAmmo):
#				currentMagAmmo = maxMagAmmo
#				currentPlayerAmmo -= reloadedAmmo
#			#if you dont have enough bullets but you have more than 0 bullets in your stash, you reload however many you have and ur stash = 0
#			elif(currentPlayerAmmo != 0):
#				currentMagAmmo += currentPlayerAmmo
#				currentPlayerAmmo = 0
	#NEEDS RELOAD PAUSE
	
func check_swap_weapon():
	if Input.is_action_pressed("right_click"):
		if weapon_swap_cooldown > 0.2:
			if(weapon_1 != null):
				if(active_weapon == weapon_1):
					if(weapon_2 != null):
						active_weapon = weapon_2
						weapon_swap_cooldown = 0
						return
			if(weapon_2 != null):
				print("we exit")
				if(active_weapon == weapon_2):
					print("we are active")
					if(weapon_1 != null):
						print("we are changing")
						active_weapon = weapon_1
						weapon_swap_cooldown = 0
		
func shoot(player_position, mouse_position):
	if Input.is_action_pressed("left_click"):
		if fire_rate_delta > active_weapon.fire_rate:
			var projectile = active_weapon.bullet_type.instance()
			projectile.set_pos(player_position)
			var middle_of_screen = get_viewport_rect().size
			middle_of_screen *= .5
			
			var direction = middle_of_screen - mouse_position
			direction = direction * -1
			print(direction)
			var projectile_spawn_loc = player_position + direction.normalized() * BULLET_OFFSET
			projectile.look_at(projectile_spawn_loc)
			projectile.set_pos(projectile_spawn_loc)
			
			projectile.set_direction(direction.normalized())
			projectile.set_speed(active_weapon.bullet_speed)
			get_parent().add_child(projectile)
			fire_rate_delta = 0
