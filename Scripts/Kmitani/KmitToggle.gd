extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	Main.kmitBall.configuration["Vibration"] = toggled_on
