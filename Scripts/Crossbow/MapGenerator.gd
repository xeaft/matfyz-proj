extends Node3D

var extremesZ : Array = [6.412, -423.373]
var extremesX : Array = [-80.695, 80.695]

var treeAmount : int = 400
var nonColTreeAmt : int = 250
var tallTreeAmount : int = 200
var smallRockAmount : int = 50
var bigRockAmount : int = 150
var logAmount : int = 250

@onready var tree : PackedScene = preload("res://Scenes/Environment/tree.tscn")
@onready var smallRock : PackedScene = preload("res://Assets/3D/smallRock.fbx")
@onready var bigRock : PackedScene = preload("res://Assets/3D/bigRock.fbx")
@onready var tower : PackedScene = preload("res://Assets/3D/tree.fbx")
@onready var tallTree : PackedScene = preload("res://Scenes/Environment/tall_tree.tscn")
@onready var log : PackedScene = preload("res://Assets/3D/treeTrunk.fbx")

@onready var GenerationConfiguration : Dictionary = {
	"normalTree": [tree, 800, -0.774],
	"tallTree": [tallTree, 400, -0.908],
	"rock": [bigRock, 400, -1.069],
	"smallRock": [smallRock, 400, -1.224],
	"log": [log, 400, -1.284],
}


func generateObject(node : Node3D, noGoZonePos : Vector3, moveDownBy : float) -> void:
	var nodeClone : Node3D = node.duplicate()
	add_child(nodeClone)
	var XPosition : float = Main.RNG.randf_range(extremesX[0], extremesX[1])
	var ZPosition : float = Main.RNG.randf_range(extremesZ[0], extremesZ[1])
	
	var pos : Vector3 = Vector3(XPosition, -0.5, ZPosition)
	var dist : float = pos.distance_to(noGoZonePos)
	
	while (dist < 4):
		XPosition = Main.RNG.randf_range(extremesX[0], extremesX[1])
		ZPosition = Main.RNG.randf_range(extremesZ[0], extremesZ[1])
		pos = Vector3(XPosition, -0.5, ZPosition)
		dist = pos.distance_to(noGoZonePos)
	
	var rot : float = Main.RNG.randf_range(0, 180)
	var newScale : float = Main.RNG.randf_range(0.8, 1.2)
	
	nodeClone.global_rotation.y = rot
	nodeClone.scale = Vector3.ONE * newScale
	nodeClone.global_position = Vector3(XPosition, moveDownBy, ZPosition)
	nodeClone.owner = self
	
func generateMap() -> void:
	var crossbowPosition : Vector3 = get_node("../../CrossbowInstance").global_position
	
	for key in GenerationConfiguration:
		var itemArr : Array = GenerationConfiguration[key]
		var obj : Node3D = itemArr[0].instantiate()
		for i in range(round(itemArr[1])):
			generateObject(obj, crossbowPosition, itemArr[2])
