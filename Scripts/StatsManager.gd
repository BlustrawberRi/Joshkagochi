extends Node

enum stats {boredom, thirst, anger, money, crime}

var stats_dict := {
	stats.boredom : 30.0,
	stats.thirst : 0.0,
	stats.anger : 0.0,
	stats.money : 70.0,
	stats.crime : 0.0,
}

var stats_changed := {
	stats.boredom : 0.0,
	stats.thirst : 0.0,
	stats.anger : 0.0,
	stats.money : 0.0,
	stats.crime : 0.0,
}

signal stat_change(stat, value)

func update_stat(stat: stats, change: float):
	var new_value = min(100, max(0, stats_dict.get(stat) + change))
	stats_dict.set(stat, new_value)
	stat_change.emit(stat, new_value)
	stats_changed.set(stat, stats_changed.get(stat) + 1)
	print("Stat: ", stat, " Value: ", stats_dict.get(stat))


func get_stat_value(stat:stats) -> int:
	return stats_dict.get(stat)
	
