extends Control
class_name Item


@export var stat: StatsManager.stats
@export_range(-20,0, 1.0) var difference: float = -10

var _is_pressed : bool
var _mouse_pos_offset : Vector2

func _process(_delta):
	if _is_pressed:
		_drag()

# deprecated, use worm_fsm._on_area_entered instead
func _on_button_pressed():
	StatsManager.update_stat(stat, difference)#StatsManager.stats_dict.get(stat) + difference)
	# i am unsure if you meant to write this but it didn't make much sense to me to already calculate the value here, when the function also does that


func _on_button_down():
	_is_pressed = true
	_mouse_pos_offset = position - get_viewport().get_mouse_position()

func _on_button_up():
	_is_pressed = false

func _drag():
	var new_position = get_viewport().get_mouse_position() + _mouse_pos_offset
	position = new_position
