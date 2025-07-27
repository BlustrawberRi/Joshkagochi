extends TextureProgressBar

@export
var stat: StatsManager.stats

func _ready():
	StatsManager.stat_change.connect(update)
	init()
	

func update(changed_stat: StatsManager.stats, new_value: float):
	if(changed_stat != stat): return
	value = new_value

func init():
	value = StatsManager.get_stat_value(stat)
