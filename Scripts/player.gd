extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown_timer: Timer = $Cooldown
signal action_done

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@export var manual_move_state = false

var exit_state = 0
# 0 = do nothing (end turn)

var current_loop = Callable()

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

func manual_move_callback() -> void:
	manual_move_state = true
	current_loop = Callable()

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if current_loop.is_valid():
		current_loop.call()
	
	if manual_move_state:
		manual_move()
	
	move_and_slide()

func _on_cooldown_timeout() -> void:
	match exit_state:
		0:
			action_done.emit()
		_:
			action_done.emit()
