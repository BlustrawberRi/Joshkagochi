extends Area2D

enum Mood{good,meh,bad}
enum Shape{chill, active}

@export var mood : Mood
@export var shape : Shape

@onready var face : AnimatedSprite2D = $CollisionShape2D/Face 
@onready var body: Sprite2D = $CollisionShape2D/Body
@onready var animation : AnimationPlayer = $AnimationPlayer

var is_idling: bool
var tween: Tween

var origin: Vector2

var is_game_over: bool = false

func _ready():
	shape = Shape.chill
	update_shape()
	origin = self.position
	update_face()
	calculate_mood()
	StatsManager.stat_change.connect(_on_stat_changed)
	

func calculate_mood():
	var previous_mood = mood
	var total_stimulation:float = 0
	var stat_count:int = 0
	for stat in StatsManager.stats_dict:
		if stat == StatsManager.stats.crime: continue # don't count crime
		if stat == StatsManager.stats.money:
			total_stimulation += 100 - StatsManager.get_stat_value(stat)
		else:
			total_stimulation += StatsManager.get_stat_value(stat)
		stat_count += 1
	total_stimulation = total_stimulation/stat_count

	#print("stim: ",total_stimulation)
	
	if total_stimulation > 70:
		mood = Mood.bad
	elif total_stimulation > 30:
		mood = Mood.meh
	else:
		mood = Mood.good
	
	if(previous_mood != mood):
		update_face()

	if(mood != Mood.bad && !is_idling):
		$AnimationPlayer.play("chilling")
		idle()

func update_face():
	match mood:
		Mood.good:
			face.play("content")
		Mood.meh:
			face.play("default")
		Mood.bad:
			face.play("bad")

func update_shape():
	match shape:
		Shape.chill:
			animation.play("chilling")
		Shape.active:
			animation.play("active")

	
func _on_stat_changed(_stat, _value):
	if is_game_over: return
	calculate_mood()

func _on_area_entered(area):
	var item = area.get_parent()
	if item is not Item: return

	for s in item.influences:
		#print (StatsManager.stats.find_key(s), item.influences[s])
		StatsManager.update_stat(s, item.influences[s])

	shape = Shape.active
	update_shape()
	# todo: start remedy periodical update


func _on_area_exited(_area):
	shape = Shape.chill
	update_shape()
	#	todo: stop remedies

func idle(): 
	is_idling = true
	
	#prevents multiple tweens firing when going from 'meh' to 'good' or vice versa
	if tween:
		tween.kill()
	
	var target_x = position.x + randi_range(-100, 100) * 2
	target_x = clampi(target_x, 560, 991)
	var target_y = position.y + randi_range(-50, 50) * 2
	target_y = clampi(target_y, 356, 594)
	if(target_x <= self.position.x):
		body.flip_h = false
		face.flip_h = false
	else:
		body.flip_h = true
		face.flip_h = true
	
	var target_destination = Vector2(target_x, target_y)
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_destination, randf_range(0.8, 2.2)).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	await tween.tween_interval(randf_range(1.2, 2.3)).finished
	tween.kill()
	if (is_idling): idle()


func _on_game_over_pressed():
	is_game_over = true
	is_idling = false
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", origin, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(body, "self_modulate", Color(1, 1, 1, 0), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	tween.tween_property(face, "self_modulate", Color(1, 1, 1, 0), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	await tween.tween_interval(1.0).finished
	tween.kill()
	

func _on_reset_pressed():
	shape = Shape.chill
	update_shape()
	self.position = origin
	update_face()
	calculate_mood()
	body.self_modulate = Color.WHITE
	face.self_modulate = Color.WHITE
	is_game_over = false
