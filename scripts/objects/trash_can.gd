class_name TrashCan
extends Area2D

@export var animation_sprite: AnimatedSprite2D



func _on_area_entered(area: Area2D) -> void:
	trigger_cooldown()

func trigger_cooldown() -> void:
	animation_sprite.play()
