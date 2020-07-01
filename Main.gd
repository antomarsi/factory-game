extends Node2D

onready var components = [
	load("res://component/BaseFactory.tscn")
	]
onready var map : TileMap = $TileMap
onready var cellOffset = map.cell_size / 2
onready var factoryHolder = $Factories
var mapArray
var mapWith = 15
var mapHeight = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	mapArray = []
	for x in range(mapWith):
		mapArray.insert(x, [])
		for y in range(mapHeight):
			mapArray[x].insert(y, null)
	
func _unhandled_key_input(event):
	if event.pressed:
		if event.scancode == KEY_1:
			var mapPosition : Vector2 = map.world_to_map(get_global_mouse_position())
			var factory = components[0].instance()
			factory.position = map.map_to_world(mapPosition) + cellOffset
			factoryHolder.add_child(factory)
			if mapArray[mapPosition.x][mapPosition.y] != null:
				mapArray[mapPosition.x][mapPosition.y].queue_free()
			mapArray[mapPosition.x][mapPosition.y] = factory
			factory.place_factory(mapPosition, mapArray)
			
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
