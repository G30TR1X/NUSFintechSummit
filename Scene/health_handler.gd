extends Node2D

@export var player: CharacterBody2D
@export var max_health: int = 100
@export var current_health: int = 100

signal update_health_bar

func take_damage(damage):
	current_health -= damage
	update_health_bar.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
