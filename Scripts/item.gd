extends Control


@export var stat: StatsManager.stats
@export_range(-20,0, 1.0) var difference: float = -10



func _on_button_pressed():
	StatsManager.update_stat(stat, difference)#StatsManager.stats_dict.get(stat) + difference)
	
	pass # Replace with function body.
