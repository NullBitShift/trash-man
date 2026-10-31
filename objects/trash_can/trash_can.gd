class_name TrashCan
extends Area2D

signal trash_deposited(data: TrashData)
signal cooldown_triggered()

@export var animation_sprite: AnimatedSprite2D
@export var coin_pop_scene: PackedScene
@export var coin_pop_offset: Marker2D

func is_in_cooldown() -> bool:
	return animation_sprite.is_playing()

func deposit_trash(trash_data: TrashData, start_position: Vector2, throw_trash_scene: PackedScene) -> bool:
	if is_in_cooldown():
		return false

	var thrown_trash = throw_trash_scene.instantiate() as ThrownTrash
	add_child(thrown_trash)
	thrown_trash.setup(trash_data.icon, start_position, global_position)
	pop_coin()
	trigger_cooldown()
	trash_deposited.emit(trash_data)
	return true

func trigger_cooldown() -> void:
	animation_sprite.play()
	cooldown_triggered.emit()

func pop_coin() -> void:
	var coin_pop = coin_pop_scene.instantiate()
	add_child(coin_pop)
	coin_pop.global_position = coin_pop_offset.global_position
