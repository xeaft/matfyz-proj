extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	Main.disableDayNightCycle = toggled_on
