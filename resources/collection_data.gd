class_name CollectionData
extends Resource

@export var max_trash_capacity: int = 1

var trash_collected: Array[TrashData] = []
var incoming_trash_count: int = 0

func is_collection_full() -> bool:
	return trash_collected.size() + incoming_trash_count >= max_trash_capacity

func add_incoming_trash() -> void:
	incoming_trash_count += 1

func add_trash(data: TrashData) -> void:
	incoming_trash_count = max(incoming_trash_count - 1, 0)
	trash_collected.append(data)

func remove_trash() -> TrashData:
	if trash_collected.is_empty():
		return null
	return trash_collected.pop_back()

func is_empty() -> bool:
	return trash_collected.is_empty()

func get_top_trash() -> TrashData:
	if trash_collected.is_empty():
		return null
	return trash_collected.back()
	