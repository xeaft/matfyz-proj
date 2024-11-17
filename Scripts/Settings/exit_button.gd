extends TextureButton


func _on_pressed() -> void:
	get_node("../../..").doHide()
