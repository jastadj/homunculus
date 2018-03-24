extends Area2D

var currentProtein

func _ready():
	connect("area_entered", self, "protein_entered")

func _physics_process(delta):
	var areas = get_overlapping_areas()
	
	#if !areas.empty():
		#print("something is inside")
	
	
func protein_entered(other):
	currentProtein = other.get_parent()
	
	print("Area " + currentProtein.name + " entered")

func getCurrentProtein():
	return currentProtein