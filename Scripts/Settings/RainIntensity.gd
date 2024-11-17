extends HSlider

@onready var valLabel : Label = get_node("../Value")

func formatText(txt : String):
	if len(txt) == 3:
		txt = "0" + txt
	return " " + txt

func _on_value_changed(nvalue: float) -> void:
	Main.rainIntensity = nvalue
	valLabel.text = formatText(str(nvalue))
