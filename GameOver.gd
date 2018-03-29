extends Node

signal presstocontinue

func _ready():
	
	connect("presstocontinue", self, "endGame")
	
	get_node("ScoreText").text = "Score : " + str(global.totalScore)
	

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("presstocontinue")
	elif Input.is_action_just_pressed("ui_cancel"):
		emit_signal("presstocontinue")

func endGame():
	get_tree().change_scene("res://MainMenu.tscn")
