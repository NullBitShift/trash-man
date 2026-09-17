extends Area2D

signal trash_collected

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		trash_collected.emit()
		queue_free()