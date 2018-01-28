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
var status_effects_list
var health = 100

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
		var ani_node = get_node("AnimatedSprite")
		var sprite_frame
		if(player_type == player_type_enum.HACKER):
			weapon_1.weapon_type = weapon_1.weapon_list.PISTOL
			sprite_frame = load("res://sources/animations/player/player_precious_animation.tres")
			ani_node.set_sprite_frames(sprite_frame)
			ani_node.set_animation("Idle")
		elif(player_type == player_type_enum.SNIPER):
			weapon_1.weapon_type = weapon_1.weapon_list.SNIPER
			weapon_2.weapon_type = weapon_2.weapon_list.PISTOL
			sprite_frame = load("res://sources/animations/player/player_silent_animation.tres")
			ani_node.set_sprite_frames(sprite_frame)
			ani_node.set_animation("Idle")
		elif(player_type == player_type_enum.INFANTRY):
			weapon_1.weapon_type = weapon_1.weapon_list.AR
			weapon_2.weapon_type = weapon_2.weapon_list.PISTOL
			sprite_frame = load("res://sources/animations/player/player_louie_animation.tres")
			ani_node.set_sprite_frames(sprite_frame)
			ani_node.set_animation("Idle")
		self.add_child(weapon_1)
		if(weapon_2 != null):
			self.add_child(weapon_2)
		active_weapon = weapon_1

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_pos()
	var player_pos = self.get_pos()
	
	fire_rate_delta = fire_rate_delta + delta
	weapon_swap_cooldown = weapon_swap_cooldown + delta
	turn(mouse_pos)
	move_boi(delta)
	shoot(player_pos, mouse_pos)
	check_swap_weapon()
	get_node("Label").set_text(str(self.health))


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
			var projectile_spawn_loc = player_position + direction.normalized() * BULLET_OFFSET
			projectile.look_at(projectile_spawn_loc)
			projectile.set_pos(projectile_spawn_loc)
			
			projectile.set_direction(direction.normalized())
			projectile.set_speed(active_weapon.bullet_speed)
			projectile.set_damage(active_weapon.base_damage) #  * get_status_effects_amount()
			get_parent().add_child(projectile)
			fire_rate_delta = 0

func get_status_effects_amount():
	var num = 1
	for status in status_effects_list:
		if (status.effectType == "damage"):
			num *= status.intensity
	return num

func turn(mouse_position):
	var middle_of_screen = get_viewport_rect().size
	middle_of_screen *= .5
	var direction = (middle_of_screen - mouse_position).normalized()
	direction = direction * -1
	var ani_node = get_node("AnimatedSprite")
	
	var up_left_weight = Vector2(-1,-1).angle_to(direction)
	var up_right_weight = Vector2(1,-1).angle_to(direction)
	var down_left_weight = Vector2(-1,1).angle_to(direction)
	var down_right_weight = Vector2(1,1).angle_to(direction)
	
	if(up_left_weight < up_right_weight):
		if(down_left_weight < up_right_weight):
			if(up_left_weight < down_right_weight):
				ani_node.set_animation("IdleBack")
			else:
				ani_node.set_animation("IdleLeft")
		else:
			ani_node.set_animation("IdleRight")
	else:
		ani_node.set_animation("Idle")
		
func take_damage(dmg):
	self.health -= dmg
	if self.health <= 0:
		destroy()

func prep_death():
	get_node('Camera2D').set_pos(self.get_pos())
	get_node('Camera2D').set_owner(self.get_parent())

func destroy():
	prep_death()
	set_fixed_process(false)
	queue_free()
	