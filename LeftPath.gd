extends Path2D

func spawnLeftProtein(ptype, tspeed):
	var leftpathproteinscene = load("res://leftpathprotein.tscn")
	var leftpathprotein = leftpathproteinscene.instance()
	add_child(leftpathprotein)
	leftpathprotein.init(ptype, tspeed)

func _ready():
	pass
	