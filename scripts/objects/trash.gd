class_name Trash
extends Area2D

@export var trash_data: TrashData
@export var sprite_node: Sprite2D 

func _ready() -> void:
	sprite_node.texture = trash_data.icon
