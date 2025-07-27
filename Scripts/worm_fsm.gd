@tool
extends Sprite2D

enum Mood{good,meh,bad}
enum Shape{chill, active}

@export var mood : Mood:
	set(new_mood):
		if mood == new_mood: return
		mood = new_mood

		if not is_node_ready():
			await ready
		update_face()

@export var shape:Shape

func _ready():
	calculate_mood()
	StatsManager.stat_change.connect(on_stat_changed)

func update_face():
	var face : Label = get_node("Face")
	match mood:
		Mood.good:
			face.text = ":)"
		Mood.meh:
			face.text = "<:|"
		Mood.bad:
			face.text = ">:("
	
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

func on_stat_changed(_stat, _value):
	calculate_mood()
