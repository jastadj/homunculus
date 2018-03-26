extends Sprite

export(float) var switchSpeed = 0.5
export(bool) var initOut = true

var outPos = Vector2(894, 314)
var inPos = Vector2(27,300)
var switcherIn = false


func _ready():
	if initOut:
		position = outPos
		switcherIn = false
	else:
		position = inPos
		switcherIn = true

func switchIn():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", outPos, inPos, switchSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	switcherIn = true
	get_node("ClickSound").play()
	
func switchOut():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", inPos, outPos, switchSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	switcherIn = false