extends Node3D
class_name Tile

var nutrients: Nutrients
var plants: Array[Plant]
var height: float
var topsoilAmount: float = 0
var sunlight: float = 1
var temp: float = -150

func _ready() -> void:
	plants.resize(8)
