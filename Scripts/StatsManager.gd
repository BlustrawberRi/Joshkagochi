extends Node

enum stats {boredom, thirst, anger, money, crime}

var stats_dict := {
	stats.boredom : 50.0,
	stats.thirst : 50.0,
	stats.anger : 50.0,
	stats.money : 50.0,
	stats.crime : 0.0,
}

var stats_dict_initial := {
	stats.boredom : 50.0,
	stats.thirst : 50.0,
	stats.anger : 50.0,
	stats.money : 50.0,
	stats.crime : 0.0,
}

signal stat_change(stat, value)

var freeze: bool = false

func reset():
	freeze = false
	for stat in stats.values().size():
		var initial_value : int = stats_dict_initial.get(stat)
		stats_dict.set(stat, stats_dict_initial.get(stat))
		stat_change.emit(stat, initial_value)

func update_stat(stat: stats, change: float):
	if(freeze): return
	var new_value = min(100, max(0, stats_dict.get(stat) + change))
	stats_dict.set(stat, new_value)
	stat_change.emit(stat, new_value)
	#print("Stat: ", stat, " Value: ", stats_dict.get(stat))

func game_over():
	freeze = true

func get_stat_value(stat:stats) -> int:
	return stats_dict.get(stat)
	
