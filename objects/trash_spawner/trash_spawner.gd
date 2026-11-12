extends Polygon2D

@onready var navigation_region: NavigationRegion2D = $NavigationRegion2D

func _ready() -> void:
	update_navigation_polygon()

func update_navigation_polygon() -> void:
	var new_navigation_polygon = NavigationPolygon.new()
	var source_geometry: NavigationMeshSourceGeometryData2D = NavigationMeshSourceGeometryData2D.new()

	source_geometry.add_traversable_outline(polygon)
	NavigationServer2D.bake_from_source_geometry_data(new_navigation_polygon,source_geometry)
	navigation_region.navigation_polygon = new_navigation_polygon
	
#TODO create a timer to spawn trash at intervals
#TODO pick a spawn point within the polygon/navigation region
#TODO implement the actual trash spawning logic
