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
	if not trash.picked_up.is_connected(_on_trash_picked_up):
		trash.picked_up.connect(_on_trash_picked_up, CONNECT_ONE_SHOT)
	trash.pickup(bag_opening)

func _on_trash_picked_up(data: TrashData) -> void:
	if trash_collected == null:
		trash_collected = []
	trash_collected.append(data)
	
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
