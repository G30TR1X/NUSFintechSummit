extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.health_handler.take_damage(10, self)
