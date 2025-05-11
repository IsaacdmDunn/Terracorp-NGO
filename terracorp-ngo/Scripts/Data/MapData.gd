extends Node3D

var Mapsize: Vector2i = Vector2i(128,128)
var Maps: Array[GridMap]
var Tiles: Array[Tile]

func _ready() -> void:
	InitResourcePerlinMap()
	InitMaps()
	InitTiles()
	
#adds maps to data set
func InitMaps():
	Maps.append($Terrain)
	Maps.append($Lichen)
	Maps.append($Moss)
	Maps.append($"Small Plants1")
	Maps.append($"Small Plants2")
	Maps.append($"Small Plants3")
	Maps.append($"Small Plants4")
	Maps.append($"Med Plants1")
	Maps.append($"Med Plants2")
	Maps.append($Trees)

#creates tiles with height and features
func InitTiles():
	for x in Mapsize.x:
		for y in Mapsize.y:
			var tileToAdd = Tile.new()
			var nutrientsToAdd = Nutrients.new()
			tileToAdd.height = randf_range(0,1) #change to perlin
			for nutrientTypes in Nutrients.NutrientType.size() - 1:
				nutrientsToAdd.SoilNutrients.append(Vector2(nutrientTypes, randf_range(0,1))) #change to perlin
			tileToAdd.nutrients = nutrientsToAdd
			Tiles.append(tileToAdd)

#inits map with perlin data for height and nutrients
func InitResourcePerlinMap():
	pass
	
