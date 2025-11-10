extends Node2D

func _process(delta: float) -> void:
	var player_pos = get_node("../Player").global_position
	for c in get_children():
		c.offset.x = (player_pos.x / 100 * c.get_meta("pos_z"))
