extends Node

@export var player_speed: float = 200.0
@export var player_base_node: CharacterBody2D

func _process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1

	if input_vector != Vector2.ZERO:
		move_player(input_vector, delta)

func move_player(direction: Vector2, delta: float) -> void:
	var movement = direction.normalized() * player_speed * delta
	player_base_node.position += movement
