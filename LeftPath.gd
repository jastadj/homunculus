extends Path2D

func spawnLeftProtein(ptype):
	var leftpathproteinscene = load("res://leftpathprotein.tscn")
	var leftpathprotein = leftpathproteinscene.instance()
	add_child(leftpathprotein)
	leftpathprotein.init(ptype)

func _ready():
	pass
	