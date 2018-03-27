extends Sprite

var phases = []

export(float) var speed = 0.2
var currentPhase = 0
var timer

func _ready():
	
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = speed * get_node("/root/World").waveSpeed
	timer.connect("timeout", self, "animatePhases")
	
	phases.append(get_node("Phase0"))
	phases.append(get_node("Phase1"))
	phases.append(get_node("Phase2"))
	
	# set initial phase visibility
	setPhase(0)
	
	timer.start()

func setPhase(p):
	
	if p == 0:
		phaseOn(0, true)
		phaseOn(1, false)
		phaseOn(2, false)
	elif p == 1:
		phaseOn(0, false)
		phaseOn(1, true)
		phaseOn(2, false)
	else:
		phaseOn(0, false)
		phaseOn(1, false)
		phaseOn(2, true)

func phaseOn(pnum, isOn):
	
	for s in phases[pnum].get_children():
		if !isOn:
			s.hide()
		else:
			s.show()

func animatePhases():
	
	currentPhase += 1
	if currentPhase > 2:
		currentPhase = 0

	setPhase(currentPhase)

	
