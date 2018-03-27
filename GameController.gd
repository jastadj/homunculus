extends Node

enum {DNA_A, DNA_T, DNA_G, DNA_C}

# screen resolution
var resolution

# area trigger looking for proteins
var inputArea

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
export(float) var waveSpeed = 0.004
export(float) var waveDelay = 1.0
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
	
	# get player controller
	player = get_node("/root/World/Player")
	player.connect("pressed_protein", self, "submitProtein")
	
	# connect player to needle
	player.connect("pressed_protein", get_node("Needle"), "injectProtein")
	
	
	# get left path node
	leftPath = get_node("/root/World/LeftPath")
	
	powerSwitcher = get_node("PowerSwitcher")
	powerSwitcher.switchOut()
	
	# reset globals
	global.lastSequenceList = []
	global.lastSuccess = 0.0
	
	# start waves
	waveText = get_node("/root/World/WaveText")
	waveText.text = ""
	nextSpawn()


func nextSpawn():
	
	#delay start
	yield(get_tree().create_timer(2.0), "timeout")
	
	# move needle into position
	get_node("Needle").moveNeedleIn()
	
	# wait a second
	yield(get_tree().create_timer(1.0), "timeout")
		
	# start wave
	for w in waves:
		
		# show wave start string
		waveText.text = "Starting DNA Sequence " + str(w+1)
		yield(get_tree().create_timer(2.0), "timeout")
		waveText.text = ""
		
		
		# start spawning proteins in wave
		for c in waveCount:
			
			var newsequence = randi()%4
			spawnLeftProtein(newsequence, waveSpeed)
			sequenceList.append(newsequence)
			
			# wait until next protein spawn
			yield(get_tree().create_timer(waveDelay), "timeout")
		
		# wait for path to be empty of any proteins
		yield(leftPath, "isEmpty")
		
		# display wave complete string
		waveText.text = "Sequence Complete!"
		yield(get_tree().create_timer(2.0), "timeout")
		waveText.text = ""
		
		# slight delay before starting next wave
		yield(get_tree().create_timer(1.0), "timeout")
	
	endLevel()

func endLevel():
	
	var sequenceSuccess = float( ( float(score) / ( float(sequenceList.size()) * points_good)) * float(100) )
	sequenceSuccess = sequenceSuccess * 100
	sequenceSuccess = floor(sequenceSuccess)
	sequenceSuccess = sequenceSuccess / 100

	#waveText.text = "Success : " + str(sequenceSuccess) + "%"
	print("Game complete with score of " + str(score) + "/" + str(sequenceList.size()*points_good) )
	yield(get_tree().create_timer(1.0), "timeout")
	
	# clear text and switch power in
	waveText.text = ""
	powerSwitcher.switchIn()
	yield(powerSwitcher.get_node("Tween"), "tween_completed")
	
	# transfer current game to globals
	global.addToTotalScore(score)
	global.setLastSuccess(sequenceSuccess)
	# note : sequencing is saved when protein is destroyed
	
	get_tree().change_scene("res://Results.tscn")

func spawnLeftProtein(ptype, tspeed):
	leftPath.spawnLeftProtein(ptype, tspeed)
	pass

#func getSpeed():
	#return speed
	
func submitProtein(source, protein):
	
	#print("submitted protein : " + str(protein) )
	
	var plist = inputArea.get_overlapping_areas()
	
	#print("proteins in area : " + str(plist.size()) )
	
	for p in plist:
		#print("protein pos: " + str(p.get_parent().get_parent().position) )
		p.get_parent().get_parent().setCompliment(protein)

func ScoreEmpty():
	#print("Score empty")
	score += points_missed

func ScoreGood():
	#print("Score good")
	score += points_good

func ScoreBad():
	#print("Score bad")
	score += points_bad

