extends Node2D

var cellsNode
var cellScene = load("res://Cell.tscn")


func _ready():
	
	cellsNode = get_node("Cells")
	
	spawnCell(-200,-220,10,10,0.2)
	spawnCell(20,300,-2,-10,0.1)
	
	var newvec = polar2cartesian(400, 0)
	
	
func spawnCell(x,y,vx,vy,r):
	var newcell = cellScene.instance()
	cellsNode.add_child(newcell)
	newcell.setPosition(x,y)
	newcell.setVelocity(vx,vy)
	newcell.setAngularVelocity(r)
	
