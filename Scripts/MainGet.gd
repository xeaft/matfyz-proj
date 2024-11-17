extends Node3D

@onready var selectedMode : String = ""
@onready var kmitaniScene : PackedScene = preload("res://Scenes/Kmitani/kmitani_screen.tscn")
var kmitBall : Node3D
var crossbow : Node3D
var dbgTxt : Label
var game : Node3D
var UI : Control
var mainMenu : Control
var debugUI : Control
var showDebug : bool = false
var enableRain : bool = false
var rainIntensity : int = 2000
var focusDart : Node3D

var RNG : RandomNumberGenerator = RandomNumberGenerator.new()

var currentProject : Node3D
var preloaded : Dictionary = {
	"kmitani": preload("res://Scenes/Kmitani/kmitani_screen.tscn"),
	"kuse": preload("res://Scenes/Crossbow/CrossbowScreen.tscn"),
}

var defaultMMThings : Array = ["UserInterface", "MainMenu", "debugui"]
func backToMainMenu() -> void:
	if dbgTxt:
		dbgTxt.text = ""
		
	for i in UI.get_children():
		i.queue_free()
	for i in game.get_children():
		if i.name not in defaultMMThings:
			i.queue_free()
	mainMenu.visible = true


func setDebugText(text: String) -> void:
	if not dbgTxt:
		return
	
	dbgTxt.text = text

func makeSceneTopmost(scene : Node) -> void:
	var sceneParent = scene.get_parent()
	sceneParent.move_child(scene, sceneParent.get_child_count())
