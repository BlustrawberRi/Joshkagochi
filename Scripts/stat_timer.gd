extends Timer

@export var stat : StatsManager.stats
@export var change : int = 0

func _on_timeout():
    StatsManager.update_stat(stat, change)
