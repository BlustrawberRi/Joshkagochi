extends Button

var possible_results = [
	"nerd", "depressed", "thirst_trap", "furry", "tax_fraud", "smooth_criminal"
]

var result_stats = {
	"nerd" : {
	StatsManager.stats.boredom : 0.0,
	StatsManager.stats.thirst : 50.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 0.0
	},
	
	"depressed" : {
	StatsManager.stats.boredom : 100.0,
	StatsManager.stats.thirst : 100.0,
	StatsManager.stats.anger : 30.0,
	StatsManager.stats.money : 50.0,
	StatsManager.stats.crime : 00.0
	},
	
	"thirst_trap": {
	StatsManager.stats.boredom : 50.0,
	StatsManager.stats.thirst : 100.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 00.0,
	},
	
	"furry": {
	StatsManager.stats.boredom : 0.0,
	StatsManager.stats.thirst : 50.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 100.0,
	StatsManager.stats.crime : 00.0
	},
	
	"tax_fraud": {
	StatsManager.stats.boredom : 50.0,
	StatsManager.stats.thirst : 50.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 100.0,
	StatsManager.stats.crime : 100.0
	},
	
	"smooth_criminal": {
	StatsManager.stats.boredom : 50.0,
	StatsManager.stats.thirst : 100.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 100.0
	}
}

signal end_game

var visible_after_item_uses = 5
var current_item_uses = 0

func _ready():
	self.visible = false
	StatsManager.stat_change.connect(check_set_visible)

func check_set_visible(_stat, _value):
	current_item_uses += 1
	if (current_item_uses >= visible_after_item_uses):
		self.visible = true

func calc_result():
	var absolute_distance = 999
	var target = ""
	for result in possible_results:
		print("checking distance to ", result)
		var local_distance = 0
		for stat in result_stats.get(result):
			var distance = abs(StatsManager.stats_dict.get(stat) - result_stats.get(result).get(stat))
			local_distance += distance
			print("----- ", distance, " from ", stat)
		print("++++ ", local_distance)
		if (local_distance <= absolute_distance):
			print("closer target found! ", result, local_distance)
			absolute_distance = local_distance
			target = result
	print("the joshkagotchi will be ", target)
	return target
	

func _on_pressed():
	calc_result()
	emit_signal("end_game")
	pass # Replace with function body.
