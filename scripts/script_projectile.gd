extends Area2D

# class member variables go here, for example:

var damage = 10
var SPEED = 50
onready var animation = get_node("AnimationPlayer")
var direction = Vector2(10, 10)  # FOR THE CHARACTER 

var hit = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	set_fixed_process(true)
	pass
	

func _fixed_process(delta):
	translate(Vector2(delta*SPEED, delta*SPEED))

func _hit_something():
	hit = true
	set_process(false)
	_destroy()


func _on_Projectile_area_enter( area ):
	# Hit an enemy or asteroid
	if (area.has_method("takedamage")):#included in the enemy
		# Duck typing at it's best
		area.takedamage()
		_hit_something()
	print ("hit area2d")

 # replace with function body

func _on_Projectile_body_enter( body ):
	# Hit the tilemap
	_hit_something()

func _destroy():
	#add animation
	animation.play("INSERT_ANIM_NAME")
	queue_free()
	
func _on_Timer_timeout():
	queue_free()
	_destroy()
	


	
	
	
	
	









