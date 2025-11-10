extends GPUParticles2D

var t = 0.0

func _process(delta: float) -> void:
	t+=delta
	if t > 0.2:
		emitting = false
	if t > 1:
		self.queue_free()
