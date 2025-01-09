extends TextureProgressBar

@onready var action_phase_ui: CanvasLayer = $".."
@onready var player = action_phase_ui.player
@onready var health_handler = player.health_handler

func health_bar():
	value = health_handler.current_health * 100 / health_handler.max_health
	print(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_handler.connect("update_health_bar",health_bar)
	health_bar()

func _process(_delta) -> void:
	pass
