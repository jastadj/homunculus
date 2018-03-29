extends Node

var totalScore = 0
var lastSequenceList = []
var lastSuccess = 0.0
var lastBaseType = ""
var level = 1
var horrorCount = 0

var dnabases = []

func addToTotalScore(addval):
	totalScore += addval

func getTotalScore():
	return totalScore

func reset():
	totalScore = 0
	lastSequenceList = []
	lastSuccess = 0.0
	level = 1
	horrorCount = 0
	
	dnabases = []
	dnabases.append("deer")
	dnabases.append("chimpanzee")
	dnabases.append("horse")
	dnabases.append("tortoise")
	dnabases.append("wolf")
	dnabases.append("cow")

func setLastSequence(seq):
	lastSequenceList = seq
	
func setLastSuccess(success):
	lastSuccess = success

func debugGlobals():
	
	print("***** SETTING DEBUG GLOBALS *****")
	reset()
	
	randomize()
	
	lastSequenceList = []
	
	for i in range(0,60):
		lastSequenceList.append(randi()%5)
		if lastSequenceList.back() == 5:
			lastSequenceList[lastSequenceList.size()-1] = null
	
	lastSuccess = 88.8
	totalScore = 550
	lastBaseType = "monkey"