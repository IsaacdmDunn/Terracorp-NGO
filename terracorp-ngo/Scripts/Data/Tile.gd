extends Node3D
class_name Tile
var tilePosition: Vector2i
var nutrients: Nutrients
var plants = []
var height: float
var topsoilAmount: float = 0
var sunlight: float = 1
var temp: float = -150
var mapRef: Node3D

#func _ready() -> void:
	#mapRef = get_tree().get_first_node_in_group("MapData2")
	#print("awdadwa")
	#while plants.size() < 8:
		#plants.append(null)

func UpdateTile():
	#if plants != null:
		#print( plants)
	if tilePosition.y < 127 and tilePosition.x < 127 and tilePosition.x > -1 and tilePosition.y > -1: 
		if randi_range(1,1) == 1 and tilePosition.x < 127 and plants.size() > 0:
			var rNum = randi_range(0,3) 
			if rNum == 0:
				SpreadPlantToAdjTile(Vector2i(1,0))
			if rNum == 1:
				SpreadPlantToAdjTile(Vector2i(0,1))
			if rNum == 2:
				SpreadPlantToAdjTile(Vector2i(-1,0))
			if rNum == 3:
				SpreadPlantToAdjTile(Vector2i(0,-1))
	
func AddPlant(type: int, plant:Plant):
	#plants[type] = plants[0]
	plants.append(plant)
	print(tilePosition)
	
func SpreadPlantToAdjTile(posOffset: Vector2i):
	var pos = (tilePosition.x * 128) + (tilePosition.y)
	mapRef.Tiles[pos + (posOffset.x * 128) + posOffset.y].AddPlant(0, plants[0])
	mapRef.get_child(9).set_cell_item(Vector3i(tilePosition.x + posOffset.x,0,tilePosition.y + posOffset.y),0,0)
