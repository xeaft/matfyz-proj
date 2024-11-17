extends Button

@export var forWhat : String

func _on_pressed() -> void:
	var sceneInstance : Node3D = Main.preloaded[forWhat].instantiate()
	Main.mainMenu.visible = false
	Main.game.add_child(sceneInstance)
	Main.makeSceneTopmost(Main.debugUI)
