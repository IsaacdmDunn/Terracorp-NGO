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
