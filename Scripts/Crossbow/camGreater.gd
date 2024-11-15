extends Button


func _on_pressed() -> void:
	var currentCam : int = Main.crossbow.camera
	if currentCam == 5:
		disabled = true
		return

	var newCam : int = currentCam + 1
	
	Main.crossbow.camera = newCam
	Main.crossbow.get_node("Cameras/" + str(currentCam)).current = false
	Main.crossbow.get_node("Cameras/" + str(newCam)).current = true
	get_node("../Label").text = "Kamera " + str(newCam)
	get_node("../Lower").disabled = false
