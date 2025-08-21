extends VBoxContainer

@export_enum("Nerd", "Depressed Baby", "Thirst Trap", "Furry", "Tax Evader", "Smooth Criminal")
var guy: String

@onready
var label = $Name

@onready
var texture = $Result

func _ready():
	label.text = "???????"
	texture.modulate = Color.BLACK

func reveal():
	label.text = guy
	texture.modulate = Color.WHITE


func _on_end_pressed():
	if(ResultCalculator.calc_result() == guy):
		reveal()
	pass # Replace with function body.
