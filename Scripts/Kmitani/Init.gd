extends Node3D

func _ready() -> void:
	Main.currentProject = get_node("Body")
	Main.UI.add_child(load("res://Scenes/UIScenes/KmitaniControl.tscn").instantiate())
