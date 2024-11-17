extends Node3D

var dart : PackedScene = preload("res://Scenes/Crossbow/crossbow_dart.tscn")

var loaded : bool = false

var crossbowUnloaded : PackedScene = preload("res://Scenes/AssetScenes/crossbow_unloaded.tscn")
var crossbowLoaded : PackedScene = preload("res://Scenes/AssetScenes/crossbow_loaded.tscn")

@onready var cam : Camera3D = get_node("../Camera")
var targetCamPos : Vector3
var targetCamRot : Vector3

func shoot() -> void:
	if not loaded:
		return
	get_child(0).queue_free()
	add_child(crossbowUnloaded.instantiate())
	loaded = false
	
	var dartInst : Node3D = dart.instantiate()
	get_parent().add_child(dartInst)
	dartInst.global_position = global_position
	dartInst.rotation = rotation
	dartInst.get_node("Dart").shoot(rotation.x)


func loadC() -> void:
	get_child(0).queue_free()
	add_child(crossbowLoaded.instantiate())
	loaded = true

func _process(_delta: float) -> void:
	var dbgTxt : String = ""
	if targetCamRot and targetCamPos:
		cam.global_position = cam.global_position.lerp(targetCamPos, 0.2)
		cam.rotation = cam.rotation.lerp(targetCamRot, 0.2)
	
	if Main.showDebug:
		var darts : int = 0
		for i in get_parent().get_children():
			if i.is_in_group("crossbow_dart"):
				darts += 1
		Main.setDebugText(dbgTxt + "Camera Position: " + str(cam.global_position) + "\nFPS: " + str(Engine.get_frames_per_second()) + "\nDarts: " + str(darts))
	
	if Input.is_action_just_released("shoot"):
		if loaded:
			shoot()
		else:
			loadC()
