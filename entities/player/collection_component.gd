extends Area2D

@export var collection_marker: Marker2D
@export var thrown_trash_scene: PackedScene
@export var max_trash_capacity: int = 1

var trash_collected: Array[TrashData]

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("trash"):
		var trash = area as Trash
		call_deferred("collect_trash", trash)

	if area.is_in_group("trash_can"):
		call_deferred("deposit_trash", area as TrashCan)

func is_collection_full() -> bool:
	if trash_collected == null:
		return false
	return trash_collected.size() >= max_trash_capacity

func collect_trash(trash: Trash) -> void:
	if is_collection_full():
		return
		
	if not trash.picked_up.is_connected(_on_trash_picked_up):
		trash.picked_up.connect(_on_trash_picked_up, CONNECT_ONE_SHOT)
	trash.pickup(collection_marker)
	
func _on_trash_picked_up(data: TrashData) -> void:
	if trash_collected == null:
		trash_collected = []
	trash_collected.append(data)

func deposit_trash(trash_can: TrashCan) -> void:
	if trash_collected == null or trash_collected.is_empty():
		return

	if trash_can.is_in_cooldown():
		return

	var trash_data = trash_collected.back()
	var success = trash_can.deposit_trash(trash_data, global_position, thrown_trash_scene)

	if success:
		trash_collected.pop_back()
