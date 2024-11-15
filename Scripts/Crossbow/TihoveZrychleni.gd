extends HSlider

@onready var val : Label = get_node("../ValueText")

func formatText(txt : String):
	var beforeDot : String = txt.split(".")[0]
	var afterDot : String = txt.split(".")[1] if txt.contains(".") else null
	
	if len(beforeDot) == 1:
		beforeDot = "0" + beforeDot
	if afterDot == null:
		afterDot = "0"
		
	return beforeDot + "." + afterDot + " ms⁻²"

func _on_value_changed(nvalue: float) -> void:
	Main.crossbow.configuration["TihoveZrychleni"] = nvalue
	val.text = formatText(str(nvalue))
