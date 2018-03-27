extends Node

var totalScore = 0
var lastSequenceList = []
var lastSuccess = 0.0
var level = 1

func addToTotalScore(addval):
	totalScore += addval

func getTotalScore():
	return totalScore

func reset():
	totalScore = 0
	lastSequenceList = []
	lastSuccess = 0.0
	level = 1

func setLastSequence(seq):
	lastSequenceList = seq
	
func setLastSuccess(success):
	lastSuccess = success
