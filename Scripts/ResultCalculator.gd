extends Node

var possible_results = [
	"Nerd", "Depressed Baby", "Thirst Trap", "Furry", "Tax Evader", "Smooth Criminal"
]

var result_stats = {
	"Nerd" : {
	StatsManager.stats.boredom : 0.0,
	StatsManager.stats.thirst : 50.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 0.0
	},
	
	"Depressed Baby" : {
	StatsManager.stats.boredom : 60.0,
	StatsManager.stats.thirst : 80.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 00.0,
	StatsManager.stats.crime : 00.0
	},
	
	"Thirst Trap": {
	StatsManager.stats.boredom : 60.0,
	StatsManager.stats.thirst : 100.0,
	StatsManager.stats.anger : 30.0,
	StatsManager.stats.money : 15.0,
	StatsManager.stats.crime : 10.0,
	},
	
	"Furry": {
	StatsManager.stats.boredom : 0.0,
	StatsManager.stats.thirst : 50.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 100.0,
	StatsManager.stats.crime : 00.0
	},
	
	"Tax Evader": {
	StatsManager.stats.boredom : 50.0,
	StatsManager.stats.thirst : 50.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 100.0,
	StatsManager.stats.crime : 100.0
	},
	
	"Smooth Criminal": {
	StatsManager.stats.boredom : 50.0,
	StatsManager.stats.thirst : 100.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 100.0
	}
}

var result_texts = {
	"Nerd": ["YOU MADE A [rainbow]Nerd[/rainbow]", "lol. lmao. *shoves u into a locker*"],
	"Depressed Baby": ["YOU GOT... oh- uh.. you got depressed :(", "Damn.... You good homie? Don't worry. Some days just suck. It takes work but don't worry. There's always another day."],
	"Thirst Trap": ["Thirst trap", "You got no money and are too hot. We gonna make lemonade out of this somehow.."],
	"Furry": ["YOU MADE A [rainbow]FURRY[/rainbow]", "owo what's this? *baps u* :3"],
	"Tax Evader": ["THE IRS IS KNOCKING", "You made so much money. there's no way you made this much and not get depressed. the only possible way to make this much money.... is TAX FRAUD!!!"],
	"Smooth Criminal": ["YOU'VE BEEN HIT BY- YOU'VE BEEN STRUCK BY-", " A [rainbow]SMOOTH CRIMINAL[/rainbow]. All that playing around with knives has been paying off."],
}


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
	
