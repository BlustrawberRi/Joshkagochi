extends Control

@export 
var result_sound : AudioStream
@export 
var result_depressed_sound : AudioStream

@onready 
var flavor_panel = $Flavor
@onready
var guy_panel = $Guy
@onready
var result_sprite : AnimatedSprite2D = $ResultSprite
@onready
var reset_button : Button = $VBoxContainer/Reset
@onready
var end_button : Button = $VBoxContainer/End

signal result_playing(sound:AudioStream)
signal reset_game

var visible_after_item_uses = 5
var current_item_uses = 0

func _ready():
	prepare()

func prepare():
	end_button.visible = false
	guy_panel.size.y = 0.0
	flavor_panel.size.y = 0.0
	result_sprite.self_modulate = Color(1,1,1,0);
	reset_button.visible = false
	start_timer()

func start_timer():
	var timer = get_tree().create_timer(5)
	await timer.timeout
	end_button.visible = true

func _on_pressed():
	StatsManager.game_over()
	var result = ResultCalculator.calc_result()
	var result_text = ResultCalculator.result_texts.get(result)


	print_rich("[rainbow]"+result+"[/rainbow]")
	if result == "Depressed Baby":
		result_playing.emit(result_depressed_sound)
	else: 
		result_playing.emit(result_sound)

	result_sprite.play(result)
	guy_panel.get_child(0).text = result_text[0]
	flavor_panel.get_child(0).text = result_text[1]
	var tween = get_tree().create_tween()
	await tween.tween_interval(2.0)
	

	tween.tween_property(result_sprite, "self_modulate", Color(1,1,1,1), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	tween.tween_property(guy_panel, "size", Vector2(636, 55), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(flavor_panel, "size", Vector2(636, 136), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	
	await get_tree().create_timer(5).timeout
	reset_button.visible = true
	


func _on_reset_pressed():
	emit_signal("reset_game")
	StatsManager.reset()
	prepare()
	pass # Replace with function body.
