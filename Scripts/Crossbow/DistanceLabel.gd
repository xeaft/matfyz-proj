extends Label3D

var timeAlive : float = 0
var distance : float = 1

func _ready() -> void:
	if name != "DefaultLabel":
		visible = true
	scale = Vector3.ZERO

func _process(delta: float) -> void:
	timeAlive += delta
	
	if timeAlive > 2:
		scale = scale.lerp(Vector3.ZERO, 0.1)
		if scale.x < 0.01:
			queue_free()
	else:
		scale = scale.lerp(Vector3.ONE * max(1, distance / 2), 0.1)
		
