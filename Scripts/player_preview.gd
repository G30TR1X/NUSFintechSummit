extends CharacterBody2D

signal changeHealth

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const MAX_HEALTH = 100
const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@export var manual_move_state = false

var currentHealth = 100

func take_damage():
	currentHealth -= 10

func manual_move() -> void:
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("moveLeft", "moveRight")
	
	# Change character direction
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
	# Animation Change
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if manual_move_state == false:
		manual_move()
	
	move_and_slide()
