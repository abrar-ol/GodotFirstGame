extends Node

@onready var scoreLabel = $"../CanvasLayer/Score"

var score = 0

func add_point () :
	score += 1
	scoreLabel.text = "Score: " + str(score)
	
