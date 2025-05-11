extends Node3D

var Mapsize: Vector2i = Vector2i(128,128)
var Maps: Array[GridMap]
var Tiles: Array[Tile]
var heightNoise = NoiseTexture2D.new()
func _ready() -> void:
	InitResourcePerlinMap()
	InitMaps()
	InitTiles()
	
func _process(delta: float) -> void:
	UpdateMap()
	pass
	
func UpdateMap():
	for x in Mapsize.x:
		for y in Mapsize.y:
			Tiles[(x * Mapsize.x) + y].UpdateTile()
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
	print(heightNoise.noise.get_noise_2d(1,1))
	$Sprite3D.texture = heightNoise
