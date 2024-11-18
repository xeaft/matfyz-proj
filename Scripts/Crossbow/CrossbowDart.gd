extends StaticBody3D

var initAngle : float
var timeFlying : float = 0
var initVeloY : float = Main.crossbow.configuration["InitialVelocity"] / 1.1
var initVeloX : float = Main.crossbow.configuration["InitialVelocity"]
var onGround : bool = false
var initPos : Vector3
var onFallPos : float
var initGlobalAngle : float

@onready var label : Label3D = get_node("../DefaultLabel")
@onready var newLabel : Label3D
@onready var lr : Node3D = Main.crossbow.get_node("LineRenderer3D")

func _ready() -> void:
	Main.focusDart = self
	lr.points.clear()

func shoot(rot : float) -> void:
	var veloXRand : float = Main.crossbow.configuration["VelocityRandomness"]
	var addVeloX : float = Main.RNG.randf_range(-veloXRand, veloXRand) / 10.0
	
	var veloYRand : float = Main.crossbow.configuration["VelocityRandomness"]
	var addVeloY : float = Main.RNG.randf_range(-veloYRand, veloYRand) / 10.0
	
	initVeloY *= sin(rot)
	initVeloX *= cos(rot)
	initVeloX += addVeloX
	initVeloY += addVeloY
	initPos = global_position
	initAngle = rot
	initGlobalAngle = global_rotation.x

func wentThroughWall(oldPos : Vector3, newPos : Vector3) -> Vector3:
	var spaceState := get_world_3d().get_direct_space_state()
	var params : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	params.from = oldPos
	params.to = newPos
	params.exclude = []
	params.collide_with_bodies = true
	params.hit_back_faces = true
	params.hit_from_inside = true
	
	var result = spaceState.intersect_ray(params)
	return Vector3() if not result else result.position

func collide() -> void:
	if onGround:
		return
		
	var distance : float = round(initPos.distance_to(global_position) * 100) / 100
	onGround = true
	if not is_instance_valid(label):
		return
	
	onFallPos = position.y
	newLabel = label.duplicate()
	newLabel.text = str(distance) + "m"
	newLabel.name = "label"
	get_parent().add_child(newLabel)
	newLabel.global_position = global_position
	newLabel.global_position.y += 1
	newLabel.distance = max(1, distance)
	

var peakYPos : float = -99.0
func _process(delta: float) -> void:
	if onGround:
		position.y = lerp(position.y, onFallPos + 0.1, 0.2)
		if is_instance_valid(newLabel):
			newLabel.global_position = global_position + Vector3.UP / 3
		return
	
	if Main.focusDart == self:
		lr.points.append(global_position)
	
	var oldPosition : Vector3 = global_position
	
	timeFlying += delta
	global_position.z = initPos.z + -(initVeloX * timeFlying)
	
	var yPosUp : float = (initVeloY * timeFlying)
	var yPosDown : float = (0.5 * Main.crossbow.configuration["TihoveZrychleni"] * timeFlying ** 2)
	
	global_position.y = initPos.y + yPosUp - yPosDown
	if global_position.y > peakYPos:
		peakYPos = global_position.y
	else:
		global_rotation.x = -initGlobalAngle
	
	var newPosition = global_position
	var colPos = wentThroughWall(oldPosition, newPosition)
	if colPos != Vector3():
		global_position = colPos
		collide()
