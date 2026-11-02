extends Area2D

@export var collection_marker: Marker2D
@export var thrown_trash_scene: PackedScene
@export var max_trash_capacity: int = 1
@export var held_item: Sprite2D

var trash_collected: Array[TrashData] = []

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("trash"):
		call_deferred("collect_trash", area as Trash)
	elif area.is_in_group("trash_can"):
		call_deferred("deposit_trash", area as TrashCan)

func is_collection_full() -> bool:
	return trash_collected.size() >= max_trash_capacity

func collect_trash(trash: Trash) -> void:
	if is_collection_full(): return
	
	if not trash.picked_up.is_connected(_on_trash_picked_up):
		trash.picked_up.connect(_on_trash_picked_up, CONNECT_ONE_SHOT)
	trash.pickup(collection_marker)

func _on_trash_picked_up(data: TrashData) -> void:
	trash_collected.append(data)
	held_item.texture = data.icon

func deposit_trash(trash_can: TrashCan) -> void:
	if trash_collected.is_empty() or trash_can.is_in_cooldown():
		return

	var item = trash_collected.back()
	if trash_can.deposit_trash(item, global_position, thrown_trash_scene):
		trash_collected.pop_back()
		held_item.texture = trash_collected.back().icon if not trash_collected.is_empty() else null
