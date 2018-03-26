extends Node

var newGameButton
var quitButton
var curButtonNum
var titleSprite
var powerSwitcher

func _ready():
	
	curButtonNum = 0
	
	newGameButton = get_node("/root/MainMenu/ButtonNewGame")
	quitButton = get_node("/root/MainMenu/ButtonQuit")
	
	newGameButton.connect("pressed", self, "startNewGame")
	quitButton.connect("pressed", self, "doQuit")
	
	titleSprite = get_node("TitleSprite")
	powerSwitcher = get_node("PowerSwitcher")
	
	powerSwitcher.get_node("Tween").connect("tween_completed", self, "switcherDone")

func _process(delta): 
	
	if curButtonNum == -1:
		return
	elif curButtonNum == 0:
		newGameButton.grab_focus()
	else:
		quitButton.grab_focus()
	
	if Input.is_action_just_pressed("ui_up"):
		curButtonNum -= 1
		if curButtonNum < 0:
			curButtonNum = 1
	elif Input.is_action_just_pressed("ui_down"):
		curButtonNum += 1
		if curButtonNum > 1:
			curButtonNum = 0
	elif Input.is_action_just_pressed("ui_accept"):
		if curButtonNum == 0:
			startNewGame()
		else:
			doQuit()

func doPowerSwitcher():
	powerSwitcher.switchIn()

func switcherDone(obj, path):
	get_tree().change_scene("res://World.tscn")

func startNewGame():
	
	print("Starting new game...")
	
	#test
	doPowerSwitcher()
	
	curButtonNum = -1
	newGameButton.queue_free()
	quitButton.queue_free()
	titleSprite.queue_free()
	
func doQuit():
	print("Quitting game...")
	get_tree().quit()
	