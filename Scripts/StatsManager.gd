extends Node

enum stats {hungry, sleepy, boredom}

var stats_dict := {
	stats.hungry : 0.0,
	stats.sleepy : 0.0,
	stats.boredom : 0.0
}

signal stat_change(stat, change)

func update_stat(stat: stats, change: float):
	stats_dict.set(stat, stats_dict.get(stat) + change)
	stat_change.emit(stat, change)
	print("Stat: ", stat, " Value: ", stats_dict.get(stat))
	
