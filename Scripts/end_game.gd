extends Button


var possible_results = [
	"nerd", "depressed", "thirst_trap",
]

var result_stats = {
	"nerd" : {
	StatsManager.stats.boredom : 10.0,
	StatsManager.stats.thirst : 2.0,
	StatsManager.stats.anger : 5.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 0.0
	},
	
	"depressed" : {
	StatsManager.stats.boredom : 0.0,
	StatsManager.stats.thirst : 0.0,
	StatsManager.stats.anger : 5.0,
	StatsManager.stats.money : 10.0,
	StatsManager.stats.crime : 0.0
	},
	
	"thirst_trap": {
	StatsManager.stats.boredom : 2.0,
	StatsManager.stats.thirst : 10.0,
	StatsManager.stats.anger : 5.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 0.0,
	}
	
}

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
			local_distance += abs(StatsManager.stats_changed.get(stat) - result_stats.get(result).get(stat))
		if (local_distance <= absolute_distance):
			print("closer target found! ", result, local_distance)
			absolute_distance = local_distance
			target = result
	print("the joshkagotchi will be ", target)
	return target
	

func _on_pressed():
	calc_result()
	pass # Replace with function body.
