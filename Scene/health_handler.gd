extends Node2D

@export var player: CharacterBody2D
@export var max_health: int = 100
@export var current_health: int = 100
@export var i_frame_handler: Callable

var invulnerability = false
signal update_health_bar

func default_i_frame():
	invulnerability = true
	player.animation_player
	await get_tree().create_timer(1.0).timeout
	invulnerability = false

func take_damage(damage):
	if !invulnerability:
		current_health -= damage
		update_health_bar.emit()
		i_frame_handler.call()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	i_frame_handler = Callable(self, "default_i_frame")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
