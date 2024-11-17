extends Button


func _on_pressed() -> void:
	var currentCam : int = Main.crossbow.camera
	if currentCam == 1:
		disabled = true
		return
	
	var newCam : int = currentCam - 1
	
	Main.crossbow.camera = newCam
	var newCamObj : Node3D = Main.crossbow.get_node("CameraInfo/" + str(newCam))
	Main.crossbow.instance.targetCamRot = newCamObj.global_rotation
	Main.crossbow.instance.targetCamPos  = newCamObj.global_position

	get_node("../Label").text = "Kamera " + str(newCam)
	get_node("../Greater").disabled = false
