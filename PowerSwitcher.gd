extends Sprite

export(float) var switchSpeed = 0.5
var outPos = Vector2(894, 314)
var inPos = Vector2(27,300)
var switcherIn = false

func _ready():
	init()

func init():
	position = outPos
	switcherIn = false

func switchIn():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", outPos, inPos, switchSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	switcherIn = true
	
func switchOut():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", inPos, outPos, switchSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	switcherIn = false