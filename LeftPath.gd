extends Path2D

signal isEmpty

func spawnLeftProtein(ptype, tspeed):
	var leftpathproteinscene = load("res://leftpathprotein.tscn")
	var leftpathprotein = leftpathproteinscene.instance()
	add_child(leftpathprotein)
	leftpathprotein.init(ptype, tspeed)

func _ready():
	pass
	
func _process(delta):
	
	if get_child_count() == 0:
		emit_signal("isEmpty")