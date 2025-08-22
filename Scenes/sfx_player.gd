extends AudioStreamPlayer


func _on_item_collided(item:Item):
    play_sound(item.sound)

func play_sound(sound:AudioStream):
    stream = sound
    play()
