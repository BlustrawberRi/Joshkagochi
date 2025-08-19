extends Control
class_name Item

@export var influences: Dictionary [StatsManager.stats, int]

var _is_pressed : bool
var _mouse_pos_offset : Vector2

var origin_pos: Vector2

func _ready():
	await get_tree().process_frame
	print(self.position)
	origin_pos = self.position

func _process(_delta):
	if _is_pressed:
		_drag()

func _on_button_down():
	_is_pressed = true
	_mouse_pos_offset = position - get_viewport().get_mouse_position()

func _on_button_up():
	_is_pressed = false
	self.position = origin_pos

func _drag():
	var new_position = get_viewport().get_mouse_position() + _mouse_pos_offset
	position = new_position
