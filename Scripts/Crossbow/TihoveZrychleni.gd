extends HSlider

@onready var val : Label = get_node("../ValueText")

func formatText(txt : String):
	var beforeDot : String = txt.split(".")[0]
	var afterDot : String = txt.split(".")[1] if txt.contains(".") else ""
	
	if len(beforeDot) == 1:
		beforeDot = "0" + beforeDot
	if afterDot == "":
		afterDot = "0"
		
	return beforeDot + "." + afterDot + " m/s²"

func _on_value_changed(nvalue: float) -> void:
	Main.crossbow.configuration["TihoveZrychleni"] = nvalue
	val.text = formatText(str(nvalue))
