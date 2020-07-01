extends Node2D

class_name BaseFactory

enum DIRECTION {
	NONE,
	UP,
	DOWN,
	LEFT,
	RIGHT
}
export var MAX_ITEM_HOLD = 10
export(DIRECTION) var CAN_ACCEPT_ITEM = null
export(DIRECTION) var CAN_EJECT_ITEM = null
var insert_factory : BaseFactory = null
var eject_factory : BaseFactory = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func place_factory(pos, mapArray):
	if CAN_EJECT_ITEM != null:
		var parentPos = pos + self.get_direction(CAN_EJECT_ITEM)
		var newParent = mapArray[parentPos.x][parentPos.y]
		if newParent != null and newParent.CAN_ACCEPT_ITEM != DIRECTION.NONE and is_oposite_direction(newParent.CAN_ACCEPT_ITEM, self.CAN_EJECT_ITEM):
			eject_factory = newParent
			eject_factory.accept_factory = self
	if CAN_ACCEPT_ITEM != null:
		var parentPos = pos + self.get_direction(CAN_ACCEPT_ITEM)
		var newParent = mapArray[parentPos.x][parentPos.y]
		if newParent != null and newParent.CAN_EJECT_ITEM != DIRECTION.NONE and is_oposite_direction(newParent.CAN_EJECT_ITEM, self.CAN_ACCEPT_ITEM):
			insert_factory = newParent
			insert_factory.eject_factory = self

func is_oposite_direction(first, second):
	return get_direction(first) + get_direction(second) == Vector2.ZERO

func get_direction(value):
	match value:
		DIRECTION.UP:
			return Vector2(0, -1)
		DIRECTION.DOWN:
			return Vector2(0, 1)
		DIRECTION.LEFT:
			return Vector2(-1, 0)
		DIRECTION.RIGHT:
			return Vector2(1, 0)
	return null
