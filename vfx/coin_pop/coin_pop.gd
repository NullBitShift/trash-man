extends AnimatedSprite2D

@export var float_distance: float = 32.0  
@export var duration: float = 0.4         

func _ready() -> void:
	animation_finished.connect(queue_free)
	play("default")
	
	scale = Vector2(0.2, 0.2)
	
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "scale", Vector2.ONE, duration)
	
	var target_position = position + Vector2(0, -float_distance)
	tween.tween_property(self, "position", target_position, duration)