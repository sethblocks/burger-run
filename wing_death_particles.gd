extends GPUParticles2D

var time = 0

func _process(delta: float) -> void:
	time+=delta
	if time >=0.2:
		emitting = false
	if time > 3:
		self.queue_free()
