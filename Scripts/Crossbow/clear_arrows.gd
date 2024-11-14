extends Button


func _on_pressed() -> void:
	for i in Main.crossbow.get_children():
		if i.is_in_group("crossbow_dart"):
			i.queue_free()
