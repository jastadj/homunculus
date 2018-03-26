extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		doQuit()
	elif Input.is_action_just_pressed("ui_cancel"):
		doQuit()
	elif Input.is_mouse_button_pressed(1):
		doQuit()

func doQuit():
	get_tree().change_scene("res://MainMenu.tscn")
	

