extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("StartSetContainer/StartPanelContainer/StartImage").set_focus_mode(FOCUS_ALL)
	get_node("StartSetContainer/StartPanelContainer/StartImage").grab_focus()
	pass


func _on_StartImage_pressed():
	print("lel")
	if(get_tree().get_root().has_node("master_scene_node/MasterSceneUI")):
		var master_ui_node = get_tree().get_root().get_node("master_scene_node/MasterSceneUI")
		master_ui_node.test("Start Button Press")
	
	pass # replace with function body

func _on_StartImage_focus_enter():
	print("got focus")
	pass # replace with function body
