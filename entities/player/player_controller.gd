extends Node

@export var player_speed: float = 200.0
@export var player_base_node: CharacterBody2D
@export var current_strategy: MovementStrategy

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if current_strategy:
		player_base_node.velocity = current_strategy.calculate_velocity(player_base_node.velocity, input_vector, delta)

	player_base_node.move_and_slide()
