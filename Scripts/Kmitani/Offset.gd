extends HSlider


func _on_value_changed(nvalue: float) -> void:
	Main.kmitBall.configuration["Offset"] = nvalue / 10
	Main.kmitBall.updatePos()
