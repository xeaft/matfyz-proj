extends HSlider

@onready var cam : Camera3D = Main.crossbow.get_node("Camera")

func _on_value_changed(nvalue: float) -> void:
	cam.rotation.x = deg_to_rad(nvalue)
