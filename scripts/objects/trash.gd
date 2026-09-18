extends Area2D

signal trash_collected

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		trash_collected.emit()
		queue_free()
