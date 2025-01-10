extends Node

@export var entity: CharacterBody2D
@export var max_health: int = 100
@export var current_health: int = 100
@export var i_frame_handler: Callable

var invulnerability = false
signal update_health_bar

func default_i_frame(delay):
	invulnerability = true
	entity.animation_player.play("invulnerability_blink")
	entity.set_collision_layer_value(2, false)
	await get_tree().create_timer(delay).timeout
	entity.set_collision_layer_value(2, true)
	entity.animation_player.stop()
	invulnerability = false

func take_damage(damage, hitter):
	if !invulnerability:
		current_health -= damage
		update_health_bar.emit()
		i_frame_handler.call(1.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	i_frame_handler = Callable(self, "default_i_frame")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
