extends Position2D

signal donePrinting

var seqScene
var sequence = []
export(float) var drawSpeed = 0.03

var colSize = 10

var spriteW
var spriteH

var timer

var printSound

func _ready():
	
	# get sequence scene
	seqScene = load("res://SequenceSprite.tscn")
	
	# get sequence sprite dimensions
	var tempsprite = seqScene.instance()
	spriteW = tempsprite.get_texture().get_width()
	spriteH = tempsprite.get_texture().get_height()
	tempsprite.queue_free()
	
	# DEBUG
	#get_parent().debugGlobals()
	
	# get sequence from global
	sequence = global.lastSequenceList
	
	printSound = get_node("PrintSound")
	
	# init timer
	timer = Timer.new()
	#timer.one_shot = true
	timer.wait_time = drawSpeed
	add_child(timer)

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

	add_child(newsprite)
	newsprite.modulate = color
	
	return newsprite
	

func drawSequence():
	
	timer.start()
	
	printSound.play()
	for p in sequence.size():
		var row = floor(p / colSize)
		var col = p - (row * colSize)
		var newsprite = createNewSprite(sequence[p])
		newsprite.position = Vector2(row*spriteW + row*spriteW,col*spriteH)
		yield(timer, "timeout")
	printSound.stop()
	
	emit_signal("donePrinting")