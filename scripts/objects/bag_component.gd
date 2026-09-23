extends Area2D

var trash_collected: Array[TrashData]

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("trash"):
		var trash = area as Trash
		call_deferred("collect_trash", trash)

	if area.is_in_group("trash_can"):
		call_deferred("deposit_trash", area as TrashCan)

func collect_trash(trash: Trash) -> void:
	trash_collected.append(trash.trash_data)
	trash.queue_free()

func deposit_trash(trash_can: TrashCan) -> void:
	var trash = trash_collected.pop_back()
	if trash == null:
		return

	if trash_can.has_method("trigger_cooldown"):
		if trash_can.animation_is_playing():
			trash_collected.append(trash)
		else:
			# TODO: add coin
			trash_can.trigger_cooldown()