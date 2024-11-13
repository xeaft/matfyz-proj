extends StaticBody3D

@onready var lineRenderer : MeshInstance3D = get_node("../LineRenderer3D")
@onready var origGlobalPos : Vector3 = global_position

var sinTimer : float
var moveTimer : float

var configuration : Dictionary = {
	"Movement": false,
	"MovementSpeed": 1.0,
	"Vibration": true,
	"VibrationSpeed": 2.0,
	"ShowPath": true,
	"MoveRight": false,
	"Offset": 0.0
}

var origConf = configuration.duplicate(true)

func _ready() -> void:
	Main.kmitBall = self

func clean() -> void:
	configuration = origConf
	reset()

func updatePathState(isVisible : bool) -> void:
	lineRenderer.visible = isVisible

func reset() -> void:
	global_position = origGlobalPos
	global_position.x += configuration["Offset"]
	sinTimer = 0
	moveTimer = 0
	lineRenderer.points.clear()
	lineRenderer.points.append(Vector3(100,100,100))
	lineRenderer.points.append(Vector3(100,150,100))
	lineRenderer.points.clear()

func roundVec(vec : Vector3) -> Vector3:
	var newVec : Vector3 = Vector3()
	for dir in "xyz":
		newVec[dir] = round(vec[dir] * 100) / 100
	return newVec

func updatePos() -> void:
	position.x = configuration["Offset"] + moveTimer

func _process(delta: float) -> void:
	Main.setDebugText("Position: " + str(global_position.y) + "\nFPS: " + str(Engine.get_frames_per_second()) + "\nPoints: " + str(len(lineRenderer.points)))
	
	if configuration["ShowPath"]:
		var pos : Vector3 = roundVec(global_position)
		if not pos in lineRenderer.points:
			lineRenderer.points.append(pos)
	
	if configuration["Vibration"]:
		sinTimer += delta * configuration["VibrationSpeed"]
		position.y = sin(sinTimer)
	
	if configuration["Movement"]:
		moveTimer += delta * configuration["MovementSpeed"] * (-1 if configuration["MoveRight"] else 1)
		updatePos()
