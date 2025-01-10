extends Node

@export var entity: CharacterBody2D
var current_action: Action
# Action <- next action
# Null <- stay at current action
var actions: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Action:
			actions[child.name.to_lower()] = child
	current_action = actions["manualmoving"]
	current_action.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_action:
		var next_action = current_action.update(delta)
		if next_action != null:
			current_action.exit()
			current_action = next_action
			current_action.enter()

func _physics_process(delta: float) -> void:
	if current_action:
		current_action.physics_update(delta)
