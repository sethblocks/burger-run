extends Label


func _process(delta: float) -> void:
	self.text = str(int(get_node("../../..").get_meta("score")))
	get_node("../Boorunum").set_meta("value", int(get_node("../../..").get_meta("health")))
	var height = 64*(float(get_node("../../..").get_meta("power") / 10))
	get_node("../../CircleOutline").region_rect = Rect2(Vector2(0,64-height), Vector2(64,height))
	height+=0.25* (height-64)
	get_node("../../CircleOutline").position = Vector2(456.0, -140.0 - int(height))
	
