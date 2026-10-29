class_name ThrownTrash
extends Sprite2D

@export_group("Throw Animation")
@export var duration: float = 0.4
@export var shrink_scale: Vector2 = Vector2(0.2, 0.2)
@export var spin_amount: float = 360.0

var target_node: Node2D

func setup(icon_texture: Texture2D, start_pos: Vector2, end_pos: Vector2) -> void:
	texture = icon_texture
	global_position = start_pos

	var tween := create_tween().set_parallel(true)
	
	tween.tween_property(self, "global_position", end_pos, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		
	tween.tween_property(self, "scale", shrink_scale, duration)
	tween.tween_property(self, "rotation", deg_to_rad(spin_amount), duration)
	tween.chain().tween_callback(queue_free)
	