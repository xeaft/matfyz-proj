extends HSlider


func _on_value_changed(nvalue: float) -> void:
	Main.crossbow.configuration["InitialVelocityX"] = nvalue
	Main.crossbow.configuration["InitialVelocityY"] = nvalue
