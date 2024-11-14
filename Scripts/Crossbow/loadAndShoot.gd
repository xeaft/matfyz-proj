extends Button


func _on_pressed() -> void:
	var cb : Node3D = Main.crossbow.instance
	if cb.loaded:
		text = "Nabít"
		cb.shoot()
	else:
		cb.loadC()
		text = "Vystřelit"
