extends Node3D

func _ready() -> void:
	Main.game = self


func _on_debugui_visibility_changed() -> void:
	Main.showDebug = visible
