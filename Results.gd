extends Node

signal presstocontinue

var screenDims

var sequence
var success

var sequenceDisplay
var successText

func _ready():
	
	# get screen dimensions
	screenDims = get_viewport().size
	
	sequence = global.lastSequenceList
	success = global.lastSuccess
	
	sequenceDisplay = get_node("SequenceDisplay")
	
	# get success text and set to blank
	successText = get_node("SuccessText")
	successText.text = ""
	
	# center sequence display on x
	var spritew = sequenceDisplay.spriteW
	sequenceDisplay.position.x = (screenDims.x / 2) - (spritew * (sequence.size() / sequenceDisplay.colSize) ) + spritew	
	
	# print score from globals
	print("proteins:" + str(sequence.size()) + " pairs:" + str(sequence.size() / 2))
	print("success:" + str(success) + "%")
	print("total score:" + str(global.totalScore))
	
	showResults()


func showResults():
	
	global.level += 1
	
	# draw sequence
	yield(get_tree().create_timer(2), "timeout")
	sequenceDisplay.drawSequence()
	
	# print success %
	yield(sequenceDisplay, "donePrinting")
	yield(get_tree().create_timer(1), "timeout")
	successText.text = "Success : " + str(success)
	get_node("ThudSound").play()
	
	
	yield(self, "presstocontinue")	
	get_tree().change_scene("res://World.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("presstocontinue")
	elif Input.is_action_just_pressed("ui_cancel"):
		emit_signal("presstocontinue")
	elif Input.is_mouse_button_pressed(1):
		emit_signal("presstocontinue")

func debugGlobals():
	
	randomize()
	
	for i in range(0,60):
		global.lastSequenceList.append(randi()%5)
		if global.lastSequenceList.back() == 5:
			global.lastSequence[global.lastSequence.size()-1] = null
	
	global.lastSuccess = 88.8
	global.totalScore = 550