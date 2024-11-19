extends HSlider

@onready var valLabel : Label = get_node("../Value")

func formatText(txt : String):
	if len(txt) == 3:
		txt = "0" + txt
	if txt.find("."):
		txt = txt.split(".")[0]
	
	return " " + txt

func _on_value_changed(nvalue: float) -> void:
	var nvalue2 : int = int(nvalue)
	Main.rainIntensity = nvalue2
	valLabel.text = formatText(str(nvalue2))
