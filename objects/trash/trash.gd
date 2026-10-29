class_name Trash
extends Area2D

@export var trash_data: TrashData
@export var sprite_node: Sprite2D 
@export var collision: CollisionShape2D

@export_group("Pickup Animation")
@export var duration: float = 3.0
@export var shrink_scale: Vector2 = Vector2(0.2, 0.2)

var is_being_picked_up: bool = false

func _ready() -> void:
	sprite_node.texture = trash_data.icon

func pickup(bag_opening: Marker2D):
	if is_being_picked_up:
		return
	is_being_picked_up = true

	collision.set_deferred("disabled", true)
	set_deferred("monitoring", false)

	var start_pos := global_position
	var tween := create_tween().set_parallel(true)

	tween.tween_method(
		func(progress: float): global_position = start_pos.lerp(bag_opening.global_position, progress),
		0.0,
		1.0, 
		duration
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	tween.tween_property(self, "scale", shrink_scale, duration)
	
	tween.chain().tween_callback(queue_free)
