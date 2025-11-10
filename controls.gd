extends RigidBody2D


var p_time = 0
var p_speed = 2

var can_dash = true

func _physics_process(delta: float) -> void:
	
	if linear_velocity.x > 400:
		set_meta("score", (get_meta("score")+1000*delta))
	p_time+=delta
	if p_time >= p_speed:
		p_time = 0
		if self.get_meta("power") < 10:
			self.set_meta("power", self.get_meta("power")+1)
	if get_meta("health") <= 0 or self.global_position.y > 1000:
		get_tree().change_scene_to_file("res://main.tscn")
	var speed_e = 1;
	if self.get_meta("inair"):
		set_meta("score", (get_meta("score")+10*delta))
		speed_e = 0.4 
	if Input.is_anything_pressed():
			if self.get_meta("inair") == false and self.get_meta("sides_touched") == false:
				if Input.is_key_pressed(KEY_SPACE):
					self.apply_force(Vector2(0,-100*(self.get_meta("jump")+abs(self.linear_velocity.x)/5)))
			if Input.is_key_pressed(KEY_SHIFT) and self.get_meta("inair") and can_dash and self.get_meta("power") >= 4:
				get_node("Camera2D").zoom = Vector2(0.9,0.9)
				self.set_meta("power", self.get_meta("power")-4)
				can_dash = false
				if Input.is_key_pressed(KEY_D):
					self.apply_impulse(Vector2(1/delta*self.get_meta("speed")*speed_e ,0))
				if Input.is_key_pressed(KEY_A):
					self.apply_impulse(Vector2(-1/delta*self.get_meta("speed")*speed_e ,0))
			else:
				if Input.is_key_pressed(KEY_D):
					self.apply_force(Vector2(1/delta*self.get_meta("speed")*speed_e ,0))
				if Input.is_key_pressed(KEY_A):
					self.apply_force(Vector2(-1/delta*self.get_meta("speed")*speed_e ,0))
				



func _on_body_entered(body: Node) -> void:
	
	if body.name == "done":
		var cong = load("res://Congrajulashins.tscn").instantiate()
		get_node("..").add_child(cong)
		get_node("../Congrajulashins/scor").text = str(int(get_meta("score")))
		for c in get_node("..").get_children():
			if c.name != "Congrajulashins":
				c.queue_free()
	if body.name == "coinbody":
		set_meta("score", (get_meta("score")+1000))
		body.get_parent().queue_free()
	if body.name == "tomatocoinbody":
		set_meta("score", (get_meta("score")+1500))
		set_meta("health", (get_meta("health")+2))
		body.get_parent().queue_free()
	if get_meta("sides_touched") == false:
		get_node("GPUParticles2D").emitting = true
	if body.name == "jumpPad":
		self.apply_force(Vector2(0,-100*(self.get_meta("jump"))*4))
	self.set_meta("inair", false)
	get_node("Camera2D").zoom = Vector2(1,1)
	can_dash = true


func _on_body_exited(body: Node) -> void:
	self.set_meta("inair", true)
	get_node("GPUParticles2D").emitting = false


func _on_sides_entered(body: Node2D) -> void:
	if body.name != "Player":
		self.set_meta("sides_touched", true)


func _on_sides_exited(body: Node2D) -> void:
	if body.name != "Player":
		self.set_meta("sides_touched", false)
