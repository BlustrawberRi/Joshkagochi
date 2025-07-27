extends Control


@export var stat: StatsManager.stats
@export_range(-20,0, 1.0) var difference: float = -10



func _on_button_pressed():
	StatsManager.stats_dict.set(stat, StatsManager.stats_dict.get(stat) + difference)
	print("Stat: ", stat, " Value: ", StatsManager.stats_dict.get(stat))
	pass # Replace with function body.
