extends Polygon2D

@export var spawn_interval: float = 5.0
@export var trash_scene: PackedScene

@onready var navigation_region: NavigationRegion2D = $NavigationRegion2D
@onready var spawn_timer: Timer = $SpawnTimer
@onready var trash_container: Node2D = $SpawnedTrash

func _ready() -> void:
	update_navigation_polygon()
	start_spawn_timer()
	
func start_spawn_timer() -> void:
	spawn_timer.wait_time = spawn_interval
	spawn_timer.one_shot = false
	spawn_timer.start()

func update_navigation_polygon() -> void:
	var new_navigation_polygon = NavigationPolygon.new()
	var source_geometry: NavigationMeshSourceGeometryData2D = NavigationMeshSourceGeometryData2D.new()

	source_geometry.add_traversable_outline(polygon)
	NavigationServer2D.bake_from_source_geometry_data(new_navigation_polygon,source_geometry)
	navigation_region.navigation_polygon = new_navigation_polygon
	await get_tree().physics_frame
	
func get_random_spawn_point() -> Vector2:
	return NavigationServer2D.map_get_random_point(
		navigation_region.get_navigation_map(),
		navigation_region.navigation_layers,
		true)

func _on_spawn_timer_timeout() -> void:
	var spawn_point: Vector2 = get_random_spawn_point()
	var trash_instance: Node2D = trash_scene.instantiate()
	trash_instance.position = spawn_point
	trash_container.add_child(trash_instance)
	spawn_timer.start()