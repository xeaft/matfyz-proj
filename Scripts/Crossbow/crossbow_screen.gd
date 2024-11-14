extends Node3D

var configuration : Dictionary = {
	"TihoveZrychleni": 10,
	"InitialVelocityX": 20.0,
	"InitialVelocityY": 20.0,
	"ShowPath": false,
	"VelocityYRandomness": 10.0,
	"VelocityXRandomness": 10.0
}

var origConf : Dictionary = configuration.duplicate(true)

@onready var instance : Node3D = get_node("CrossbowInstance")

func setRotation(rot : float) -> void:
	instance.rotation.x = deg_to_rad(rot)

func clean() -> void:
	configuration = origConf

func _ready() -> void:
	Main.crossbow = self
	Main.currentProject = self
	Main.UI.add_child(load("res://Scenes/Crossbow/crossbow_config.tscn").instantiate())
