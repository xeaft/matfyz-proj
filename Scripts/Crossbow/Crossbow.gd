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

@onready var sun : DirectionalLight3D = get_node("../DirectionalLight3D")
var time : float = 0
const SKY_NORMAL_COLOR : Color = Color(0.385, 0.454, 0.55, 1)
const SKY_NIGHT_COLOR : Color = Color(0.0774, 0.1632, 0.3003, 1)
const SKY_HOR_NIGHT : Color = Color(0.0742, 0.0771, 0.0818, 1)
const SKY_HOR_DAY : Color = Color(0.6463, 0.6558, 0.6708, 1)
const DAY_NIGHT_CYCLE_SPEED : float = 2

func _process(delta: float) -> void:
	sun.rotation.x += deg_to_rad(delta * DAY_NIGHT_CYCLE_SPEED)
	var degRot : float = rad_to_deg(sun.rotation.x)
	if degRot >= 360:
		sun.rotation.x = deg_to_rad(-360 + (degRot - 360))
		
	if (degRot > 0 and degRot < 180) or (degRot < -180 and degRot > -360):
		updateSkyColor(SKY_NIGHT_COLOR, SKY_HOR_NIGHT)
		sun.rotation.x += deg_to_rad(delta * DAY_NIGHT_CYCLE_SPEED * 3) # faster night cycle
	else:
		updateSkyColor(SKY_NORMAL_COLOR, SKY_HOR_DAY)
		
	
	var dbgTxt : String = ""
	if targetCamRot and targetCamPos:
		cam.global_position = cam.global_position.lerp(targetCamPos, 0.1)
		cam.rotation.y = lerp(cam.rotation.y, targetCamRot.y, 0.1)
		cam.rotation.z = lerp(cam.rotation.z, targetCamRot.z, 0.1)
	
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

func updateSkyColor(nSkyTopCol : Color, nSkyHorCol : Color) -> void:
	var skyTopCol : Color = Main.environment.environment.sky.sky_material.sky_top_color
	var skyHorCol : Color = Main.environment.environment.sky.sky_material.sky_horizon_color
	var gndHorCol : Color = Main.environment.environment.sky.sky_material.ground_horizon_color
	var weight : float = 0.15

	Main.environment.environment.sky.sky_material.sky_top_color = skyTopCol.lerp(nSkyTopCol, weight)
	Main.environment.environment.sky.sky_material.sky_horizon_color = skyHorCol.lerp(nSkyHorCol, weight)
	Main.environment.environment.sky.sky_material.ground_horizon_color = gndHorCol.lerp(nSkyHorCol, weight)
