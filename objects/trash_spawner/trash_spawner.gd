extends Timer

@export var spawn_interval: float = 5.0
@export var trash_scene: PackedScene
@export var trash_data_choices: Array[TrashData]
@export var play_area: Polygon2D

@onready var trash_container: Node2D = $SpawnedTrash

func _ready() -> void:
	start_spawn_timer()

func pick_random_trash_data() -> TrashData:
	return trash_data_choices[randi() % trash_data_choices.size()]

func start_spawn_timer() -> void:
	wait_time = spawn_interval
	one_shot = false
	start()

func _on_spawn_timer_timeout() -> void:
	var spawn_point: Vector2 = play_area.get_random_spawn_point()
	var trash_instance: Node2D = trash_scene.instantiate()
	var trash_data: TrashData = pick_random_trash_data()
	trash_instance.position = spawn_point
	trash_instance.trash_data = trash_data
	trash_container.add_child(trash_instance)
	start()
