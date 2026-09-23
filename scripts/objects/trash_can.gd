class_name TrashCan
extends Area2D

@export var animation_sprite: AnimatedSprite2D

func animation_is_playing() -> bool:
	return animation_sprite.is_playing()

func trigger_cooldown() -> void:
	animation_sprite.play()
