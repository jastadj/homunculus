extends Node

var newGameButton
var howToPlayButton
var quitButton
var curButtonNum
var titleSprite
var powerSwitcher

func _ready():
	
	curButtonNum = 0
	
	# get buttons
	newGameButton = get_node("ButtonNewGame")
	howToPlayButton = get_node("ButtonHowToPlay")
	quitButton = get_node("ButtonQuit")
	
	# connect button press to functions
	newGameButton.connect("pressed", self, "startNewGame")
	howToPlayButton.connect("pressed", self, "showHowToPlay")
	quitButton.connect("pressed", self, "doQuit")
	
	# get other menu elements
	titleSprite = get_node("TitleSprite")
	powerSwitcher = get_node("PowerSwitcher")
	
	# connect switcher tween
	powerSwitcher.get_node("Tween").connect("tween_completed", self, "switcherDone")
	
	# test global score
	print("Total score = " + str(global.getTotalScore()) )

func _process(delta): 
	
	
	# determine which buttons are in focus if
	# valid current button num is set
	if curButtonNum == -1:
		return
	elif curButtonNum == 0:
		newGameButton.grab_focus()
	elif curButtonNum == 1:
		howToPlayButton.grab_focus()
	elif curButtonNum == 2:
		quitButton.grab_focus()
	
	# handle button focus and executing button
	if Input.is_action_just_pressed("ui_up"):
		curButtonNum -= 1
		if curButtonNum < 0:
			curButtonNum = 2
	elif Input.is_action_just_pressed("ui_down"):
		curButtonNum += 1
		if curButtonNum > 2:
			curButtonNum = 0
	elif Input.is_action_just_pressed("ui_accept"):
		if curButtonNum == 0:
			startNewGame()
		elif curButtonNum == 1:
			showHowToPlay()
		elif curButtonNum == 2:
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
	
func showHowToPlay():
	get_tree().change_scene("res://HowToPlay.tscn")
	