extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ENEMY_ROBOT_SPEED = 0.75
var AGGRO_RANGE = 400
var BULLET_OFFSET = 20
var fire_rate_delta = 0

var aggro
var player
var weapon
var weapon_pack
var health

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	aggro = false
	weapon_pack = preload("res://scenes/scene_weapon.tscn")
	weapon = weapon_pack.instance()
	weapon.weapon_type = weapon.weapon_list.ROBOT
	
	health = 100
	
	self.add_child(weapon)
	if self.get_parent() != null:
		player = self.get_parent().get_node('player')
	set_fixed_process(true)
	
func _fixed_process(delta):
	fire_rate_delta += delta
	do_ai_pattern()
	get_node('HealthLabel').set_text(str(self.health))
	
func do_ai_pattern():
	if player != null: 
		var player_pos = player.get_pos()
		var distance_to_player = self.get_pos().distance_to(player_pos)
		var direction_to_player = player_pos - self.get_pos()
		if distance_to_player < AGGRO_RANGE or aggro:
			aggro = true
			self.move(direction_to_player.normalized() * ENEMY_ROBOT_SPEED)
			shoot(player_pos, direction_to_player)
	
func shoot(player_position, dir_to_player):
	if fire_rate_delta > weapon.fire_rate:
		print(fire_rate_delta)
		var projectile = weapon.bullet_type.instance()
		projectile.set_new_owner(self)
		projectile.set_pos(self.get_pos())
		projectile.look_at(self.get_pos() + dir_to_player.normalized() * BULLET_OFFSET)
		projectile.set_pos(self.get_pos() + dir_to_player.normalized() * BULLET_OFFSET)
		projectile.set_direction(dir_to_player.normalized())
		projectile.set_speed(weapon.bullet_speed)
		projectile.set_damage(weapon.base_damage)

		get_parent().add_child(projectile)
		fire_rate_delta = 0
		
func take_damage(dmg):
	self.health -= dmg
	if self.health <= 0:
		destroy()
		
func destroy():
	set_fixed_process(false)
	queue_free()