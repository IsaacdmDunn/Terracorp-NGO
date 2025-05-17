extends Node3D
class_name Plant

enum PlantType {Lichen, Moss, SmallPlant, MedianPlant, TreePlant}
var health: float
var tempTolarance: Vector2
var nutrientRequirements: Array[Nutrients]
var nutrientStored: Array[Nutrients]
var plantType: PlantType
var modelID = 0
var plantName = ""
var growthAmount = 0
var fertileAllowed = false

func Ready() -> void:
	plantType = PlantType.SmallPlant
	health = 10
	growthAmount = 0
	fertileAllowed = false
func Update():
	growthAmount +=10
	if growthAmount > 250:
		plantType = PlantType.MedianPlant
	elif growthAmount > 100:
		plantType = PlantType.TreePlant
	if growthAmount > 500:
		fertileAllowed = true
	health-=1
	pass
