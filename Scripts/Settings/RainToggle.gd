extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	Main.enableRain = toggled_on
