class_name Player

extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown_timer: Timer = $Cooldown
@onready var health_handler: Node2D = $HealthHandler
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal action_done

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@export var manual_move_state = false
# always return to "false" the default value after every action

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

func _ready() -> void:
	_on_action_phase_ui_manual_move_init()

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

func manual_move_exit_state():
	manual_move_state = false
	action_done.emit()
	cooldown_timer.disconnect("timeout", manual_move_exit_state)

func _on_action_phase_ui_manual_move_init() -> void:
	current_loop = Callable()
	manual_move_state = true
	cooldown_timer.start(5)
	cooldown_timer.connect("timeout", manual_move_exit_state)
