class_name TrashCan
extends Area2D

@export var animation_sprite: AnimatedSprite2D
@export var coin_pop_scene: PackedScene
@export var coin_pop_offset: Marker2D

func animation_is_playing() -> bool:
	return animation_sprite.is_playing()

func trigger_cooldown() -> void:
	animation_sprite.play()

func pop_coin() -> void:
	var coin_pop = coin_pop_scene.instantiate()
	add_child(coin_pop)
	coin_pop.global_position = coin_pop_offset.global_position
