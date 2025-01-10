extends Action
class_name ManualMoving
@export var entity: CharacterBody2D
@export var entity_sprite: AnimatedSprite2D
@export var cooldown_timer: Timer
@export var jump_velocity: float = -400.0
@export var speed: float = 200.0
@export var next_action: Action

func enter():
	cooldown_timer.start(5)

func exit():
	pass

func update(_delta: float):
	if cooldown_timer.is_stopped():
		return next_action
	else:
		return null

func physics_update(_delta: float):
	# Handle jump.
	if Input.is_action_just_pressed("jump") and entity.is_on_floor():
		entity.velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("moveLeft", "moveRight")
	
	# Change character direction
	if direction > 0:
		entity_sprite.flip_h = false
	elif direction < 0:
		entity_sprite.flip_h = true
		
	# Animation Change
	if entity.is_on_floor():
		if direction == 0:
			entity_sprite.play("idle")
		else:
			entity_sprite.play("run")
	
	if direction:
		entity.velocity.x = direction * speed
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, speed)
