extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var spawn_location = Vector2(1088, 870)
var list_of_transmission_buffs = ["SNIPER"]
var game_info_instance
var level_manager_instance

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_r1_body_enter(body):
	print("Entered area 1")
	activate_buff(1, list_of_transmission_buffs, body)
	pass # replace with function body


func _on_r2_body_enter(body):
	activate_buff(2, list_of_transmission_buffs, body)
	pass # replace with function body


func _on_r3_body_enter(body):
	activate_buff(3, list_of_transmission_buffs, body)
	pass # replace with function body


func _on_r4_body_enter(body):
	activate_buff(4, list_of_transmission_buffs, body)
	pass # replace with function body

func activate_buff(room_num, list_of_transmission_buffs, body):
	if(body == get_node("player")):
		var buff_manager = get_tree().get_root().get_node("BuffManager")
		buff_manager.activate_buffs(room_num, list_of_transmission_buffs)


func _on_complete_body_enter( body ):
	if(body == get_node("player")):
		print("ended")
		level_manager_instance.char_selection_visibility_toggle()
	#	self.set_hidden(true)
		level_manager_instance.set_hidden(false)
		self.queue_free()
	pass # replace with function body
