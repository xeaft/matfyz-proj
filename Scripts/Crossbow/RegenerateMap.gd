extends Button


func _on_pressed() -> void:
	var defaultDeco : Node3D = Main.crossbow.get_node("Room/DefaultDecoration")
	if defaultDeco:
		defaultDeco.queue_free()
	var decoNode : Node3D = Main.crossbow.get_node("Room/Decoration")
	decoNode.visible = true
	for i in decoNode.get_children():
		if i.is_inside_tree():
			i.queue_free()
	
	decoNode.generateMap()
