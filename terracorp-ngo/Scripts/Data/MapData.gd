extends Node3D
var count = 0
var Mapsize: Vector2i = Vector2i(128,128)
var Maps: Array[GridMap]
var Tiles: Array[Tile]
var heightNoise = NoiseTexture2D.new()
func _ready() -> void:
	add_to_group("MapData2")
	InitResourcePerlinMap()
	InitMaps()
	InitTiles()
	var testTree = Node3D.new()
	testTree.set_script(load("res://Scripts/Characters/Trees/TestTree.gd"))
	
	Tiles[2304].plants.append(testTree)
	#$Trees.set_cell_item(Vector3i(1,0,1),0,0)
	print(Tiles[2304].plants[0])
	
func _process(delta: float) -> void:
	var dropPlane  = Plane(Vector3(0, 1, 0), 5)
	var position3D = dropPlane.intersects_ray(
							 $"../Camera3D".project_ray_origin(get_viewport().get_mouse_position()),
							 $"../Camera3D".project_ray_normal(get_viewport().get_mouse_position()))
	#if position3D.x < Mapsize.x-1 and position3D.z < Mapsize.y-1 and position3D.x > 0 and position3D.z > 0:
		#$Trees.set_cell_item(position3D,0,0)
	$Trees.set_cell_item(Vector3i(18,0,0),0,0)
	UpdateMap()
	pass
	

	
func UpdateMap():
	for i in 128:
		Tiles[count + i].UpdateTile()
	count += 128
	#print(count)
	if count > 128 * 128 -1:
		count = 0
	pass
	
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

#creates tiles with height and features using perlin
func InitTiles():
	for x in Mapsize.x:
		for y in Mapsize.y:
			var tileToAdd = Tile.new()
			var nutrientsToAdd = Nutrients.new()
			tileToAdd.height = randf_range(0,1) #change to perlin
			for nutrientTypes in Nutrients.NutrientType.size() - 1:
				nutrientsToAdd.SoilNutrients.append(Vector2(nutrientTypes, heightNoise.noise.get_noise_2d(x + (nutrientTypes + 1 * Mapsize.x),y + (nutrientTypes + 1 * Mapsize.y)))) #change to perlin
			tileToAdd.nutrients = nutrientsToAdd
			tileToAdd.tilePosition = Vector2i(x,y)
			tileToAdd.mapRef = get_tree().get_first_node_in_group("MapData2")
			#tileToAdd._ready()
			Tiles.append(tileToAdd)

#inits map with perlin data for height and nutrients
func InitResourcePerlinMap():
	heightNoise.height = GameResources.noiseMapSettings[0]
	heightNoise.width = GameResources.noiseMapSettings[1]
	heightNoise.noise = FastNoiseLite.new()
	heightNoise.noise.seed = GameResources.gameSeed
	heightNoise.noise.noise_type = GameResources.noiseMapSettings[2]
	heightNoise.noise.frequency = GameResources.noiseMapSettings[3]
	heightNoise.noise.fractal_type = GameResources.noiseMapSettings[4]
	heightNoise.noise.fractal_octaves = GameResources.noiseMapSettings[5]
	heightNoise.noise.fractal_lacunarity = GameResources.noiseMapSettings[6]
	heightNoise.noise.fractal_gain = GameResources.noiseMapSettings[7]
	heightNoise.noise.fractal_weighted_strength = GameResources.noiseMapSettings[8]
	$Sprite3D.texture = heightNoise
