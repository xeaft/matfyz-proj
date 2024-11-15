extends Button


func _on_pressed() -> void:
	var cb : Node3D = Main.crossbow.instance
	if cb.loaded:
		cb.shoot()
		text = "Nabít"
	else:
		cb.loadC()
		text = "Vystřelit"
