extends Control

@onready var button = $Button
@onready var panel = $Panel

func _ready():
	panel.visible = false
	

func _on_button_pressed():
	panel.visible = !panel.visible
	if(panel.visible):
		button.text = "Close"
	else:
		button.text = "Enguyclopedia"
