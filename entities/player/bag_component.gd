extends Area2D

@export var bag_opening: Marker2D
@export var thrown_trash_scene: PackedScene

var trash_collected: Array[TrashData]

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("trash"):
		var trash = area as Trash
		call_deferred("collect_trash", trash)

	if area.is_in_group("trash_can"):
		call_deferred("deposit_trash", area as TrashCan)

func collect_trash(trash: Trash) -> void:
	trash_collected.append(trash.trash_data)
	trash.pickup(bag_opening)

func deposit_trash(trash_can: TrashCan) -> void:
	if trash_can.has_method("trigger_cooldown"):
		if trash_can.animation_is_playing():
			return
		else:
			var trash_data = trash_collected.pop_back()
			if trash_data == null:
				return
			var thrown_trash = thrown_trash_scene.instantiate() as ThrownTrash
			trash_can.add_child(thrown_trash)
			thrown_trash.setup(trash_data.icon, global_position, trash_can.global_position)
			trash_can.pop_coin()
			trash_can.trigger_cooldown()
