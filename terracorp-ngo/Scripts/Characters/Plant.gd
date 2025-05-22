extends Node3D
class_name Plant

enum PlantType {Lichen, Moss, SmallPlant, MedianPlant, TreePlant}
var health: float
var tempTolarance: Vector2

var nutrientRequirements: Array[Vector2] = [Vector2(Nutrients.NutrientType.Water, .5), Vector2(Nutrients.NutrientType.Oxygen, .01), Vector2(Nutrients.NutrientType.Carbon, 0.5),
	Vector2(Nutrients.NutrientType.Nitrogen, 0.5), Vector2(Nutrients.NutrientType.Potassium, 0.5), Vector2(Nutrients.NutrientType.Salt, 0), Vector2(Nutrients.NutrientType.Sulfur, 0.001)]
	
var nutrientStored: Array[Vector2]
var nutrientLimit: Array[Vector2]
var plantType: PlantType
var modelID = 0
var plantName = ""
var growthAmount = 0
var fertileAllowed = false
var starving = false
