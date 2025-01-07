extends Node

@onready var ui: CanvasLayer = $"../UI"

var score = 0

func add_point():
	score += 1
	ui.get_node("Label").text = str(score)
