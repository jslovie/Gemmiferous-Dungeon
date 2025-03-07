extends Node

var rarities = {
	"attack" : 6,
	"shield" : 2,
	"heal" : 2,
}

var rng = RandomNumberGenerator.new()

func get_rng():
	rng.randomize()
	
	var weigted_sum = 0
	
	for n in rarities:
		weigted_sum += rarities[n]
	
	var item = rng.randi_range(0, weigted_sum)

	for n in rarities:
		if item <= rarities[n]:
			return n
		item -= rarities[n]
