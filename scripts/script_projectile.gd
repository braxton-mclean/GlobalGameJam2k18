extends Area2D

# class member variables go here, for example:

var speed = 5
onready var animation = get_node("AnimationPlayer")
var direction = Vector2(10, 10)  # FOR THE CHARACTER 
export var animationName = "enter name"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	pass
	

func _fixed_process(delta):
	translate(direction*speed)

func _hit_something():
	set_process(false)
	_destroy()

func _on_Projectile_area_enter( area ):
	# Hit an enemy or asteroid
	if (area.has_method("health")):#included in the enemy
		# Duck typing at it's best
		area.takedamage()
		_hit_something()
	print ("hit area2d")
	get_node("AnimationPlayer").play(animationName)

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
	


	
	
	
	
	









