extends HSlider


func _on_value_changed(nvalue: float) -> void:
	Main.kmitBall.configuration["MovementSpeed"] = nvalue / 100 * 6
