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

# score
var score = 0
var sequenceList = []
const points_good = 20
const points_bad = 5
const points_missed = 0

# waves
export(int) var waves = 1
export(int) var waveCount = 10
export(float) var initialWaveSpeed = 0.008
var waveText

# power switcher
var powerSwitcher

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
	
	powerSwitcher = get_node("PowerSwitcher")
	powerSwitcher.switchOut()
	
	# start waves
	waveText = get_node("/root/World/WaveText")
	waveText.text = ""
	nextSpawn()


func nextSpawn():
	
	#delay start
	yield(get_tree().create_timer(2.0), "timeout")
		
	# start wave
	for w in waves:
		
		waveText.text = "Starting DNA Sequence " + str(w+1)
		yield(get_tree().create_timer(2.0), "timeout")
		waveText.text = ""
		
		
		# spawn wave count
		for c in waveCount:
			
			var newsequence = randi()%4
			spawnLeftProtein(newsequence, initialWaveSpeed)
			sequenceList.append(newsequence)
			
			yield(get_tree().create_timer(2.0), "timeout")
		
		waveText.text = "Sequence Complete!"
		yield(get_tree().create_timer(2.0), "timeout")
		waveText.text = ""
		
		yield(get_tree().create_timer(1.0), "timeout")
	
	var sequenceSuccess = float( ( float(score) / ( float(sequenceList.size()) * points_good)) * float(100) )
	sequenceSuccess = sequenceSuccess * 100
	sequenceSuccess = floor(sequenceSuccess)
	sequenceSuccess = sequenceSuccess / 100

	waveText.text = "Success : " + str(sequenceSuccess) + "%"
	print("Game complete with score of " + str(score) + "/" + str(sequenceList.size()*points_good) )
	
	yield(get_tree().create_timer(3.0), "timeout")
	get_tree().change_scene("res://MainMenu.tscn")

func spawnLeftProtein(ptype, tspeed):
	leftPath.spawnLeftProtein(ptype, tspeed)
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
	score += points_missed

func ScoreGood():
	print("Score good")
	score += points_good

func ScoreBad():
	print("Score bad")
	score += points_bad

