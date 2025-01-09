extends TextureProgressBar

@export var player: CharacterBody2D

func health_bar():
	value = player.currentHealth * 100 / player.MAX_HEALTH

# Called when the node enters the scene tree for the first time.
func _process(delta) -> void:
	player.connect("changeHealth",player.take_damage)
	health_bar()
