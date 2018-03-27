extends Node2D

enum {DNA_A, DNA_T, DNA_G, DNA_C}

var colors = []

var startPos = Vector2(817,575)
var endPos = Vector2(640,480)
var speed = 0.1
var tween
var needleIn = false

var emitter
var timer
export(float) var emitTime = 0.2

func _ready():
	
	emitter = get_node("Emitter")
	
	colors.append(Color(0,1,0))
	colors.append(Color(1,1,0))
	colors.append(Color(0,0,1))
	colors.append(Color(1,0,0))
	
	
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = emitTime
	timer.one_shot = true
	
	
	tween = get_node("Tween")
	tween.connect("tween_completed", self, "needleIsIn")
	
	# get and connect player signal in game controller
	
func moveNeedleIn():
	tween.interpolate_property(self, "position", startPos, endPos, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
func needleIsIn(src, k):
	needleIn = true
	
func injectProtein(source, p):
	if needleIn == false:
		return
	if timer.is_stopped() == false:
		return
	
	emitter.modulate = colors[p]
	emitter.emitting = true
	timer.start()
	yield(timer, "timeout")
	emitter.emitting = false