extends Node3D

var dart : PackedScene = preload("res://Scenes/Crossbow/crossbow_dart.tscn")

var loaded : bool = false

var crossbowUnloaded : PackedScene = preload("res://Scenes/AssetScenes/crossbow_unloaded.tscn")
var crossbowLoaded : PackedScene = preload("res://Scenes/AssetScenes/crossbow_loaded.tscn")

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
	if Input.is_action_just_released("shoot"):
		if loaded:
			shoot()
		else:
			loadC()
