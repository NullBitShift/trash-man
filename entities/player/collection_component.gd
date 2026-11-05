class_name CollectionComponent
extends Area2D

@export var collection_marker: Marker2D
@export var thrown_trash_scene: PackedScene
@export var held_item: Sprite2D
@export var trash_collected: CollectionData

func _ready() -> void:
	if not trash_collected:
		trash_collected = CollectionData.new()
	_update_held_item()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("trash"):
		call_deferred("collect_trash", area as Trash)
	elif area.is_in_group("trash_can"):
		call_deferred("deposit_trash", area as TrashCan)

func collect_trash(trash: Trash) -> void:
	if trash_collected.is_collection_full(): 
		_play_full_feedback()
		return
	
	trash_collected.add_incoming_trash()

	if not trash.picked_up.is_connected(_on_trash_picked_up):
		trash.picked_up.connect(_on_trash_picked_up, CONNECT_ONE_SHOT)
	trash.pickup(collection_marker)

func deposit_trash(trash_can: TrashCan) -> void:
	if trash_collected.is_empty() or trash_can.is_in_cooldown():
		return

	var item = trash_collected.get_top_trash()
	if trash_can.deposit_trash(item, global_position, thrown_trash_scene):
		trash_collected.remove_trash()
		_update_held_item()
		
func _update_held_item() -> void:
	var top_trash = trash_collected.get_top_trash()
	held_item.texture = top_trash.icon if top_trash else null

func _on_trash_picked_up(data: TrashData) -> void:
	trash_collected.add_trash(data)
	_update_held_item()

func _play_full_feedback() -> void:
	if not held_item:
		return

	var tween := create_tween()
	for i in range(2):
		tween.tween_property(held_item, "scale", Vector2(1.5, 1.5), 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(held_item, "modulate", Color.RED, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.chain().tween_property(held_item, "scale", Vector2.ONE, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(held_item, "modulate", Color.WHITE, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		