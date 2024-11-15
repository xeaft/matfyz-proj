extends HSlider

@onready var val : Label = get_node("../ValueLabel")

func formatText(txt : String):
	txt = txt.split(".")[0]
	if len(txt) == 1:
		txt = "0" + txt
		
	return txt + "°"
	
func _on_value_changed(nvalue: float) -> void:
	val.text = formatText(str(nvalue))
	Main.crossbow.setRotation(90-nvalue)
