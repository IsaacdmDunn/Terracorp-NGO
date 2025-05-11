extends Node3D
class_name Tile

var nutrients: Nutrients
var plants: Array[Plant]
var height: float
var topsoilAmount: float = 0
var sunlight: float = 1
var temp: float = -150
var mapRef: Node3D

func _ready() -> void:
	mapRef = get_tree().get_first_node_in_group("MapData")
	plants.resize(8)

func UpdateTile():
	print(get_instance_id())
	pass
