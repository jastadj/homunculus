extends Node


export(float) var speed
export(float) var maxSpeed
export(float) var spawnDelay
export(float) var minSpawnDelay
export(float) var startSpawnDelay

enum {DNA_A, DNA_T, DNA_G, DNA_C}

# screen resolution
var resolution

# area trigger looking for proteins
var inputArea
var inputAreaY

# player controller
var player

# left path
var leftPath

# timer / speed
var mytimer

func _ready():
	
	# init seed
	randomize()
	
	# capture screen size
	resolution=Vector2(get_viewport().size.x, get_viewport().size.y)
	
	# get input area node and input y position
	inputArea = get_node("/root/World/InputArea")
	inputAreaY = get_node("/root/World/InputAreaSprite").position.y
	
	# get player controller
	player = get_node("/root/World/Player")
	player.connect("pressed_protein", self, "submitProtein")
	
	# get left path node
	leftPath = get_node("/root/World/LeftPath")
	
	# setup timer
	mytimer = Timer.new()
	add_child(mytimer)
	mytimer.set_one_shot(false)
	mytimer.set_wait_time(startSpawnDelay)
	mytimer.connect("timeout", self, "nextSpawn")
	mytimer.start()


func nextSpawn():
	
	mytimer.set_wait_time(spawnDelay)
	mytimer.start()
	spawnLeftProtein(randi()%4)

func spawnLeftProtein(ptype):
	leftPath.spawnLeftProtein(ptype)
	pass

func spawnProtein_old(ptype, nisleft):
	var proteinScene = load("res://protein.tscn")
	var protein = proteinScene.instance()
	
	get_node("/root/World").add_child(protein)
	protein.init(ptype, nisleft)
	
	if nisleft:
		protein.position = Vector2((resolution.x/2)-100 + 10, -30)
	else:
		protein.position = Vector2((resolution.x/2)+100-12, -30)
	
	return protein

func getSpeed():
	return speed
	
func submitProtein(source, protein):
	
	print("submitted protein : " + str(protein) )
	
	var plist = inputArea.get_overlapping_areas()
	
	print("proteins in area : " + str(plist.size()) )
	
	for p in plist:
		print("protein pos: " + str(p.get_parent().get_parent().position) )
		p.get_parent().get_parent().setCompliment(protein)

func ScoreEmpty():
	print("Score empty")

func ScoreGood():
	print("Score good")

func ScoreBad():
	print("Score bad")

	
