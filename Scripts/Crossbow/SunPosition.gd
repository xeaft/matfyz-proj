extends HSlider

@onready var sun : DirectionalLight3D = Main.crossbow.get_node("DirectionalLight3D")

func _on_value_changed(nvalue: float) -> void:
	sun.rotation.y = deg_to_rad(nvalue)
