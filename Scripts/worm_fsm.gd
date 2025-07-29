@tool
extends Sprite2D

enum Mood{good,meh,bad}
enum Shape{chill, active}

@export var mood : Mood

@export var shape:Shape

func _ready():
	calculate_mood()
	StatsManager.stat_change.connect(_on_stat_changed)

func calculate_mood():
	var total_stimulation = 0
	for stat in StatsManager.stats_dict:
		total_stimulation += StatsManager.get_stat_value(stat)
	total_stimulation = total_stimulation/StatsManager.stats_dict.size()

	print("stim: ",total_stimulation)
	
	if total_stimulation > 70:
		mood = Mood.bad
	elif total_stimulation > 30:
		mood = Mood.meh
	else:
		mood = Mood.good
		
	update_face()

func update_face():
	var face : Label = get_node("Face")
	match mood:
		Mood.good:
			face.text = ":)"
		Mood.meh:
			face.text = "<:|"
		Mood.bad:
			face.text = ">:("
	
func _on_stat_changed(_stat, _value):
	calculate_mood()
