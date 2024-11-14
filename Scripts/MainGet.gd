extends Node3D

@onready var selectedMode : String = ""
@onready var kmitaniScene : PackedScene = preload("res://Scenes/Kmitani/kmitani_screen.tscn")
var kmitBall : Node3D
var crossbow : Node3D
var dbgTxt : Label
var game : Node3D
var UI : Control
var mainMenu : Control

var RNG : RandomNumberGenerator = RandomNumberGenerator.new()

var currentProject : Node3D
var preloaded : Dictionary = {
	"voda": preload("res://Scenes/Kmitani/kmitani_screen.tscn"),
	"kmitani": preload("res://Scenes/Kmitani/kmitani_screen.tscn"),
	"hazeni": preload("res://Scenes/Kmitani/kmitani_screen.tscn"),
	"kuse": preload("res://Scenes/Crossbow/CrossbowScreen.tscn"),
}

var defaultMMThings : Array = ["UserInterface", "MainMenu"]
func backToMainMenu() -> void:
	for i in UI.get_children():
		if i.name != "dbgInfo":
			i.queue_free()
	for i in game.get_children():
		if i.name not in defaultMMThings:
			i.queue_free()
	mainMenu.visible = true


func setDebugText(text: String) -> void:
	if not dbgTxt:
		return
	
	dbgTxt.text = text
