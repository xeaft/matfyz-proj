extends Control

func _ready() -> void:
	Main.settingsMenu = self

func _process(_delta: float) -> void:
	if visible and Input.is_action_just_pressed("Escape"):
		doHide()


@onready var animPlayer : AnimationPlayer = get_node("AnimationPlayer")
func doHide() -> void:
	animPlayer.play("ToggleVisibility")
	await animPlayer.animation_finished
	visible = false
	
func doShow() -> void:
	animPlayer.play_backwards("ToggleVisibility")
	visible = true
	await animPlayer.animation_finished
