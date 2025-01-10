extends Action
class_name SwitchToCardUI

@export var action_fsm: Node
@onready var card_phase_ui: CanvasLayer = action_fsm.entity.card_phase_ui
var card_phase_finished = false
var next_action: Action

func enter():
	card_phase_finished = false
	card_phase_ui.action_done()
	card_phase_ui.connect("card_phase_done", finish_card_phase)

func finish_card_phase(action):
	card_phase_finished = true
	next_action = action
	
func exit():
	card_phase_ui.disconnect("card_phase_done", finish_card_phase)

func update(_delta: float):
	if card_phase_finished:
		return next_action
	else:
		return null

func physics_update(_delta: float):
	pass
