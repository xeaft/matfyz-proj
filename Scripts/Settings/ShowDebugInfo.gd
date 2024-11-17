extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	Main.debugUI.visible = toggled_on
