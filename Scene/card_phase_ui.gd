extends CanvasLayer

@onready var card_pile_ui: CardPileUI = $CardPileUI
@onready var energy_label: Label = $EnergyLabel

var starting_energy := 4
var current_hovered_card : CardUI
var energy := 4 :
	set(val):
		energy = val
		_update_display()

signal manual_move_init

func _update_display():
	energy_label.text = "%s" % [ energy ]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_action_done() -> void:
	get_tree().paused = true
	show()
	for card in card_pile_ui.get_cards_in_pile(CardPileUI.Piles.hand_pile):
		card_pile_ui.set_card_pile(card, CardPileUI.Piles.discard_pile)
	card_pile_ui.draw(7)
	energy = starting_energy
	

func _on_end_turn_button_pressed() -> void:
	manual_move_init.emit()
	get_tree().paused = false
	hide()
