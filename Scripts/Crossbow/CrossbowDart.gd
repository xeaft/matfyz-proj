extends RigidBody3D

func shoot(rot : float) -> void:
	apply_impulse(Vector3(0, rot * 10, -10))
