extends Node

signal presstocontinue

var sequenceDisplay

func _ready():
	
	sequenceDisplay = get_node("SequenceDisplay")
	get_node("PresstoContinue").hide()
	
	# DEBUG ONLY
	#global.debugGlobals()
	
	showResults()


func showResults():
	
	global.level += 1
	
	# move panel down into place
	yield(get_tree().create_timer(2), "timeout")
	sequenceDisplay.displayDown()
	yield(sequenceDisplay, "panelIsDown")
	
	# once panel is down, start drawing sequence
	yield(get_tree().create_timer(0.5), "timeout")
	sequenceDisplay.drawSequence()
	
	# after sequence drawing is done, show success %
	yield(sequenceDisplay, "donePrinting")
	yield(get_tree().create_timer(1.25), "timeout")
	sequenceDisplay.drawSuccessText()
	
	yield(get_tree().create_timer(1.0), "timeout")
	sequenceDisplay.clearSequences()
	sequenceDisplay.drawSummary()
	
	get_node("PresstoContinue").show()
	yield(self, "presstocontinue")
	sequenceDisplay.displayUp()
	get_node("PresstoContinue").hide()
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	if global.horrorCount >= 2:
		get_tree().change_scene("res://GameOver.tscn")
	else:
		get_tree().change_scene("res://World.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("presstocontinue")
	elif Input.is_action_just_pressed("ui_cancel"):
		emit_signal("presstocontinue")


