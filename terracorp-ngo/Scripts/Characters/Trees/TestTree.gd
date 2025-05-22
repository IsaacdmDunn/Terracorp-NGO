extends Plant

var spreadRate = 5000

func Ready() -> void:
	nutrientRequirements = [Vector2(Nutrients.NutrientType.Water, .5), Vector2(Nutrients.NutrientType.Oxygen, .01), Vector2(Nutrients.NutrientType.Carbon, 0.5),
	Vector2(Nutrients.NutrientType.Nitrogen, 0.5), Vector2(Nutrients.NutrientType.Potassium, 0.5), Vector2(Nutrients.NutrientType.Salt, 0), Vector2(Nutrients.NutrientType.Sulfur, 0.001)]
	
	plantType = PlantType.SmallPlant
	health = 10
	growthAmount = 0
	fertileAllowed = false
func Update():
	growthAmount +=10
	if growthAmount > 250:
		plantType = PlantType.TreePlant
	elif growthAmount > 100:
		plantType = PlantType.MedianPlant
	if growthAmount > 500:
		fertileAllowed = true
	if starving:
		health -= 1
	else:
		growthAmount +=10
	pass
