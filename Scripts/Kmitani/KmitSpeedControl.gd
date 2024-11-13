extends HSlider

func _on_value_changed(nvalue: float) -> void:
	Main.kmitBall.configuration["VibrationSpeed"] = nvalue / 100 * 6
