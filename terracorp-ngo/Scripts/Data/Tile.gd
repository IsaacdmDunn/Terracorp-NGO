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
	for p in plants.size():
		if plants[p] != null:
			
			if plants[p].nutrientRequirements != null:
				for nutrient in plants[p].nutrientRequirements.size():
					if nutrients.SoilNutrients[nutrient].y > plants[p].nutrientRequirements[nutrient].y:
						plants[p].starving = true
						break
					else:
						plants[p].starving = false
			
			if plants[p].fertileAllowed == true: 
				
				SpreadPlant()
			plants[p].Update()
			
			UpdatePlant(p)
			

#adds plant to layer on tile
func AddPlant(plantLayer: int, plant:Plant):
	plants[plantLayer] = plant
	plants[plantLayer].Ready()
	
#updates plant
func UpdatePlant(plantID):
	if plants[plantID].health < 0:
		KillPlant(plants[plantID],plantID)
	else:
		growIntoNewTile(plantID, plants[plantID].plantType)
	#grow from small plant to med
	#if plants[plantID].plantType == plants[plantID].PlantType.MedianPlant:
		#if plants[3] == null:
			#plants[3] = plants[plantID]
			#print("jhvjhvjh")
			#mapRef.get_child(3).set_cell_item(Vector3i(tilePosition.x,0,tilePosition.y),-1,0)
			#mapRef.get_child(7).set_cell_item(Vector3i(tilePosition.x,0,tilePosition.y),0,0)
			#KillPlant(plants[plantID], plantID)
	##grow med plant to large
	#elif plants[plantID].plantType == plants[plantID].PlantType.TreePlant:
		#if plants[7] == null:
			#plants[7] = plants[plantID]
			#mapRef.get_child(7).set_cell_item(Vector3i(tilePosition.x,0,tilePosition.y),-1,0)
			#mapRef.get_child(9).set_cell_item(Vector3i(tilePosition.x,0,tilePosition.y),0,0)
			#KillPlant(plants[plantID], plantID)
	 #fix out of bounds bug

#spreads plant when fertile
func SpreadPlant(): 
	if tilePosition.y < mapRef.Mapsize.y-1 and tilePosition.x < mapRef.Mapsize.x-1 and tilePosition.x > -1 and tilePosition.y > -1: 
		for i in plants.size():
			if randi_range(1,8) == 1 and plants[i] != null: #if ready to grow and tile has plant
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
	
#sets plant to adj tile
func SpreadPlantToAdjTile(posOffset: Vector2i, plantLayer: int):
	var pos = (tilePosition.x * mapRef.Mapsize.x) + (tilePosition.y)
	mapRef.Tiles[pos + (posOffset.x * mapRef.Mapsize.x) + posOffset.y].AddPlant(plantLayer, plants[plantLayer])
	mapRef.get_child(3).set_cell_item(Vector3i(tilePosition.x + posOffset.x,0,tilePosition.y + posOffset.y),0,0)
	
#kills plant
func KillPlant(plant, plantLayer:int): 
	plant = null
	mapRef.get_child(plantLayer+2).set_cell_item(Vector3i(tilePosition.x,0,tilePosition.y),-1,0)
	plants[plantLayer] = null

func growIntoNewTile(plantID: int, plantType: int):
	if plantType == 3: #small to med
		var emptySpaces = []
		if plants[5] == null:
			emptySpaces.append(7)
		if plants[6] == null:
			emptySpaces.append(8)	
		if 	!emptySpaces.is_empty():
			var newLandID = randi_range(0, emptySpaces.size()-1)
			plants[emptySpaces[newLandID] - 2] = plants[plantID]
			mapRef.get_child(plantID).set_cell_item(Vector3i(tilePosition.x,0,tilePosition.y),-1,0)
			mapRef.get_child(emptySpaces[newLandID]).set_cell_item(Vector3i(tilePosition.x,0,tilePosition.y),0,0)
			KillPlant(plants[plantID], plantID)
	elif plantType == 4: #med to large
		if plants[7] == null:
			plants[7] = plants[plantID]
			mapRef.get_child(plantID).set_cell_item(Vector3i(tilePosition.x,0,tilePosition.y),-1,0)
			mapRef.get_child(9).set_cell_item(Vector3i(tilePosition.x,0,tilePosition.y),0,0)
			KillPlant(plants[plantID], plantID)
	pass
