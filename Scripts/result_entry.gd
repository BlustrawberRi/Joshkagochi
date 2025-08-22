extends VBoxContainer

@export_enum("Nerd", "Depressed Baby", "Thirst Trap", "Furry", "Tax Evader", "Smooth Criminal")
var guy: String

@onready
var name_label = $Name
@onready
var desc_label = $Description
@onready
var texture = $Result

func _ready():
	name_label.text = "???????"
	desc_label.text = ""
	texture.modulate = Color.BLACK

func reveal():
	name_label.text = guy
	texture.modulate = Color.WHITE
	desc_label.text = ResultCalculator.result_texts.get(guy)[1]


func _on_end_pressed():
	if(ResultCalculator.calc_result() == guy):
		reveal()
	pass # Replace with function body.
