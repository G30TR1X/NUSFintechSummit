extends TextureProgressBar

@export var action_phase_ui: CanvasLayer
@onready var player = action_phase_ui.player
@onready var health = player.health_handler

func health_bar():
	value = health.current_health * 100 / health.max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.connect("update_health_bar",health_bar)
	health_bar()

func _process(_delta) -> void:
	pass
