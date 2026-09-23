extends Area2D

var trash_collected: Array[TrashData]

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("trash"):
		var trash = area as Trash
		call_deferred("collect_trash", trash)

func collect_trash(trash: Trash) -> void:
	trash_collected.append(trash.trash_data)
	trash.queue_free()
	print(trash_collected)