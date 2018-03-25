extends PathFollow2D

export(float) var speed

signal compliment_empty
signal compliment_bad
signal compliment_good

func init(ptype):
	get_child(0).set_frame(ptype)
	get_child(1).texture = null
	

func _ready():
	
	# connect signals to game controller
	var gc = get_node("/root/World")
	connect("compliment_empty", gc, "ScoreEmpty")
	connect("compliment_bad", gc, "ScoreBad")
	connect("compliment_good", gc, "ScoreGood")
	
	
	set_process(true)
	

func _process(delta):
	
	# move object along path
	unit_offset += speed
	
	# protein is being deleted once off screen
	if unit_offset > 0.85:
		
		# determine if protein has proper matching protein
		if get_child(1).texture == null:
			emit_signal("compliment_empty")
		
		queue_free()

func setCompliment(ptype):
	
	# if compliment has already been assigned, ignore
	if get_child(1).texture != null:
		return
		
	get_child(1).texture = load("res://atgc.png")
	get_child(1).set_frame(ptype)

	var p = get_child(0).frame
	var cp = get_child(1).frame
	
	if p == 0 && cp == 1:
		emit_signal("compliment_good")
	elif p == 1 && cp == 0:
		emit_signal("compliment_good")
	elif p == 2 && cp == 3:
		emit_signal("compliment_good")
	elif p == 3 && cp == 2:
		emit_signal("compliment_good")
	else:
		emit_signal("compliment_bad")
