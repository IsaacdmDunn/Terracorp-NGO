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

func _ready() -> void:
	#mapRef = get_tree().get_first_node_in_group("MapData2")
	#print("awdadwa")
	while plants.size() < 8:
		plants.append(null)

func UpdateTile():
	if tilePosition.y < mapRef.Mapsize.y-1 and tilePosition.x < mapRef.Mapsize.x-1 and tilePosition.x > -1 and tilePosition.y > -1: 
		for i in plants.size():
			if randi_range(1,1) == 1 and plants[i] != null: #if ready to grow and tile has plant
				#spread to adj
				var rNum = randi_range(0,3) 
				if rNum == 0:
					SpreadPlantToAdjTile(Vector2i(1,0), i)
				if rNum == 1:
					SpreadPlantToAdjTile(Vector2i(0,1), i)
				if rNum == 2:
					SpreadPlantToAdjTile(Vector2i(-1,0), i)
				if rNum == 3:
					SpreadPlantToAdjTile(Vector2i(0,-1), i)

#adds plant to layer on tile
func AddPlant(plantLayer: int, plant:Plant):
	plants[plantLayer] = plant

#sets plant to adj tile
func SpreadPlantToAdjTile(posOffset: Vector2i, plantLayer: int):
	var pos = (tilePosition.x * mapRef.Mapsize.x) + (tilePosition.y)
	mapRef.Tiles[pos + (posOffset.x * mapRef.Mapsize.x) + posOffset.y].AddPlant(plantLayer, plants[plantLayer])
	mapRef.get_child(9).set_cell_item(Vector3i(tilePosition.x + posOffset.x,0,tilePosition.y + posOffset.y),0,0)
