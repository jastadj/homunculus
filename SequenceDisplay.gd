extends Position2D

signal donePrinting
signal panelIsDown
signal panelIsUp



var seqScene
var successText

# sequence sprite
export(float) var drawSpeed = 0.03
var colSize = 10
var spriteW
var spriteH
var spriteScale = 0.25
var seqDrawPos

# timers
var timer
var glitchTimer

# sounds
var printSound
var thudSound
var clickInSound
var clickOutSound

# panel and panel tween
var panelSprite
var tweenSpeed = 0.2
var inPos = Vector2(0,400)
var outPos

# panel glitch shader
var glitch

func _ready():
	
	# init out position
	outPos = position
	
	# get sequence scene
	seqScene = load("res://SequenceSprite.tscn")
	
	# get sequence sprite dimensions
	var tempsprite = seqScene.instance()
	spriteW = tempsprite.get_texture().get_width()
	spriteH = tempsprite.get_texture().get_height()
	tempsprite.queue_free()
	seqDrawPos = Vector2( -spriteW*spriteScale * 6, -25)
	seqDrawPos.x = seqDrawPos.x + (spriteW*spriteScale)
	
	# get sprites
	panelSprite = get_node("PanelSprite")
	
	# get sounds
	printSound = get_node("PrintSound")
	thudSound = get_node("ThudSound")
	clickInSound = get_node("ClickInSound")
	clickOutSound = get_node("ClickOutSound")
	
	# get labels
	successText = panelSprite.get_node("SuccessText")
	
	
	# get glitch shader material
	glitch = get_node("PanelSprite/Control/ColorRect").get_material()
	
	# init timer
	timer = Timer.new()
	#timer.one_shot = true
	timer.wait_time = drawSpeed
	add_child(timer)
	
	# clear label
	successText.text = ""


func _process(delta):
	pass
	
	#glitch.set_shader_param("DispSize", 0.5)

func displayDown():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", outPos, outPos + inPos, tweenSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	emit_signal("panelIsDown")
	clickInSound.play()
	
func displayUp():
	clickOutSound.play()
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", outPos + inPos, outPos, tweenSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	emit_signal("panelIsUp")
	

func drawSequence():
	
	# get sequence from global
	var sequence = global.lastSequenceList
	
	timer.start()
	
	printSound.play()
	for p in sequence.size():
		var row = floor(p / colSize)
		var col = p - (row * colSize)
		var newsprite = createNewSprite(sequence[p])
		newsprite.position = Vector2(row*spriteW + row*spriteW,col*spriteH)*spriteScale
		newsprite.position = newsprite.position + seqDrawPos
		yield(timer, "timeout")
	printSound.stop()
	
	emit_signal("donePrinting")

func clearSequences():
	panelSprite.get_node("Sequences").queue_free()
	
func drawSuccessText():
	successText.text = "Success : " + str(global.lastSuccess) + "%"
	thudSound.play()
	
func drawSummary():
	var txt = get_node("PanelSprite/SummaryText")
	var success = global.lastSuccess
	
	var rating = ""
	var basetype = global.lastBaseType
	
	if success == 100.0:
		rating = "GODLIKE"
	elif success >= 90.0:
		rating = "Superior"
	elif success >= 80.0:
		rating = "Normal"
	elif success >= 70.0:
		rating = "Mutant"
	elif success >= 60.0:
		rating = "Fodder"
	else:
		rating = "Horror"
		global.horrorCount += 1
	
	txt.text = "\nRating : " + rating + "\n\nBase Type : " + basetype
	
func clearSummary():
	get_node("PanelSprite/SummaryText").text = ""

func enableInput():
	get_node("CreationName").grab_focus()

func createNewSprite(protein):
	
	var newsprite = seqScene.instance()
	var alphamin = 0.2
	var alphamax = 1.0
	var alpha = rand_range(alphamin, alphamax)
	var color = Color(0,0,0, alpha)
	
	
	if protein == null:
		color = Color(1,1,1,0)
	else:
		if protein == 0:
			color = Color(0,1,0,alpha)
		elif protein == 1:
			color = Color(1,1,0,alpha)
		elif protein == 2:
			color = Color(0,0,1,alpha)
		elif protein == 3:
			color = Color(1,0,0,alpha)

	panelSprite.get_node("Sequences").add_child(newsprite)
	newsprite.modulate = color
	newsprite.scale = Vector2(spriteScale,spriteScale)
	
	return newsprite