extends Node

var totalScore = 0

func addToTotalScore(addval):
	totalScore += addval

func getTotalScore():
	return totalScore

func clearTotalScore():
	totalScore = 0
