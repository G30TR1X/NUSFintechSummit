class_name Player

extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown_timer: Timer = $Cooldown
@onready var health_handler: Node = $PlayerHealthHandler
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var card_phase_ui: CanvasLayer
@onready var action_fsm: Node = $ActionFSM

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@export var manual_move_state = false
# always return to "false" the default value after every action

var current_loop = Callable()

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
