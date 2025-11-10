extends PathFollow2D

var dir = 0

func _ready() -> void:
	get_node("AnimationPlayer").current_animation = "new_animation"
	get_node("AnimationPlayer").seek(randf_range(0.0,1.0))
