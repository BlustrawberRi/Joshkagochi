extends Control

@onready 
var flavor_panel = $Flavor
@onready
var guy_panel = $Guy
@onready
var result_sprite : AnimatedSprite2D = $ResultSprite

var possible_results = [
	"nerd", "depressed", "thirst_trap", "furry", "tax_fraud", "smooth_criminal"
]

var result_stats = {
	"nerd" : {
	StatsManager.stats.boredom : 0.0,
	StatsManager.stats.thirst : 50.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 0.0
	},
	
	"depressed" : {
	StatsManager.stats.boredom : 100.0,
	StatsManager.stats.thirst : 100.0,
	StatsManager.stats.anger : 30.0,
	StatsManager.stats.money : 50.0,
	StatsManager.stats.crime : 00.0
	},
	
	"thirst_trap": {
	StatsManager.stats.boredom : 50.0,
	StatsManager.stats.thirst : 100.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 00.0,
	},
	
	"furry": {
	StatsManager.stats.boredom : 0.0,
	StatsManager.stats.thirst : 50.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 100.0,
	StatsManager.stats.crime : 00.0
	},
	
	"tax_fraud": {
	StatsManager.stats.boredom : 50.0,
	StatsManager.stats.thirst : 50.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 100.0,
	StatsManager.stats.crime : 100.0
	},
	
	"smooth_criminal": {
	StatsManager.stats.boredom : 50.0,
	StatsManager.stats.thirst : 100.0,
	StatsManager.stats.anger : 50.0,
	StatsManager.stats.money : 0.0,
	StatsManager.stats.crime : 100.0
	}
}

var result_texts = {
	"nerd": ["YOU MADE A [rainbow]NERD[/rainbow]", "lol. lmao. *shoves u into a locker*"],
	"depressed": ["YOU GOT... oh- uh.. you got depressed :(", "it happens to the best of us <:) Dont be hard on yourself. It's never too late to try again!"],
	"thirst_trap": ["Thirst trap", "You got no money and are too hot. We gonna make lemonade out of this somehow.."],
	"furry": ["YOU MADE A [rainbow]FURRY[/rainbow]", "owo what's this? *baps u* :3"],
	"tax_fraud": ["THE IRS IS KNOCKING", "You made so much money. there's no way you made this much and not get depressed. the only possible way to make this much money.... is TAX FRAUD!!!"],
	"smooth_criminal": ["YOU'VE BEEN HIT BY- YOU'VE BEEN STRUCK BY-", " A [rainbow]SMOOTH CRIMINAL[/rainbow]. All that playing around with knives has been paying off."],
}

signal end_game

var visible_after_item_uses = 5
var current_item_uses = 0

func _ready():
	self.visible = false
	StatsManager.stat_change.connect(check_set_visible)
	guy_panel.size.y = 0.0
	flavor_panel.size.y = 0.0
	result_sprite.self_modulate = Color(1,1,1,0);

func check_set_visible(_stat, _value):
	current_item_uses += 1
	if (current_item_uses >= visible_after_item_uses):
		self.visible = true

func calc_result():
	var absolute_distance = 999
	var target = ""
	for result in possible_results:
		print("checking distance to ", result)
		var local_distance = 0
		for stat in result_stats.get(result):
			var distance = abs(StatsManager.stats_dict.get(stat) - result_stats.get(result).get(stat))
			local_distance += distance
			print("----- ", distance, " from ", stat)
		print("++++ ", local_distance)
		if (local_distance <= absolute_distance):
			print("closer target found! ", result, local_distance)
			absolute_distance = local_distance
			target = result
	print("the joshkagotchi will be ", target)
	return target
	

func _on_pressed():
	var result = calc_result()
	var result_text = result_texts.get(result)
	emit_signal("end_game")

	result_sprite.play(result)
	guy_panel.get_child(0).text = result_text[0]
	flavor_panel.get_child(0).text = result_text[1]
	var tween = get_tree().create_tween()
	await tween.tween_interval(1.0)
	
	tween.tween_property(result_sprite, "self_modulate", Color(1,1,1,1), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	tween.tween_property(guy_panel, "size", Vector2(636, 55), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(flavor_panel, "size", Vector2(636, 136), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

	pass # Replace with function body.
