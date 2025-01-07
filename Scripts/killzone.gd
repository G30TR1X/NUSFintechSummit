extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("Player has died")
	Engine.time_scale = 0.5 
	body.get_node("Box").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	print("Player Revived!")
	Engine.time_scale = 1
	get_tree().reload_current_scene()
