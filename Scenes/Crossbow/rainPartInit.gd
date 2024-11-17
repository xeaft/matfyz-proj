extends CPUParticles3D

func _ready() -> void:
	emitting = Main.enableRain
	amount = Main.rainIntensity
