extends Node3D

var configuration : Dictionary = {
	"TihoveZrychleni": 10,
	"InitialVelocity": 20.0,
	"ShowPath": false,
	"VelocityRandomness": 10.0,
}

var origConf : Dictionary = configuration.duplicate(true)
var camera : int = 1

@onready var instance : Node3D = get_node("CrossbowInstance")

func setRotation(rot : float) -> void:
	instance.rotation.x = deg_to_rad(rot)

func clean() -> void:
	configuration = origConf

func _ready() -> void:
	Main.crossbow = self
	Main.currentProject = self
	Main.UI.add_child(load("res://Scenes/Crossbow/crossbow_config.tscn").instantiate())
	if Main.enableRain:
		get_node("NormalEnvironment").queue_free()
	else:
		get_node("RainEnvironment").queue_free()
