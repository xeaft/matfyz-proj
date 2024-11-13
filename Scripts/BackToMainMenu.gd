extends Button

func _on_pressed() -> void:
	Main.currentProject.clean()
	Main.backToMainMenu()
