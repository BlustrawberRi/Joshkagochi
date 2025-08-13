extends Node

enum stats {boredom, thirst, anger, money, crime}

var stats_dict := {
	stats.boredom : 50.0,
	stats.thirst : 20.0,
	stats.anger : 0.0,
	stats.money : 20.0,
	stats.crime : 0.0,
}

signal stat_change(stat, value)

func update_stat(stat: stats, change: float):
	var new_value = max(0, stats_dict.get(stat) + change)
	stats_dict.set(stat, new_value)
	stat_change.emit(stat, new_value)
	print("Stat: ", stat, " Value: ", stats_dict.get(stat))

func get_stat_value(stat:stats) -> int:
	return stats_dict.get(stat)
	
