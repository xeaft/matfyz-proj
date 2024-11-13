extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	Main.kmitBall.configuration["ShowPath"] = toggled_on
	Main.kmitBall.updatePathState(toggled_on)
