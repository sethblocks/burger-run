
extends RigidBody2D

var dashing = false

const particles_2 = preload("res://ketchup_explode.tscn")
var particles = preload("res://wing_death_particles.tscn").instantiate()
# Basic AI, goomba-like
func _ready() -> void:
	get_node("AnimationPlayer2").current_animation = "float"
var alive = 1;
func _on_top_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var p = particles_2.instantiate()
		p.global_position = global_position + Vector2(0,-50)
		get_node("..").add_child(p)
		
		body.apply_impulse(Vector2(0,-body.linear_velocity.y *1.5))
		body.set_meta("score", (body.get_meta("score")+300))
		alive = 0
		
		particles.global_position = global_position
		get_node("..").add_child(particles)
		self.queue_free() # TODO: Animate

func _physics_process(delta: float) -> void:
	if (position.distance_to(get_node("../Player").position))  < 420:
		var dif = position - get_node("../Player").position
		if (position.distance_to(get_node("../Player").position)) < 300 and dashing == false:
			self.apply_impulse(-dif/2)
			dashing = true
		if (position.distance_to(get_node("../Player").position)) > 350:
			dashing = false
		self.apply_force(-dif)
		
		
	
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	self.queue_free()


func _on_eside_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.set_meta("score", (body.get_meta("score")-200))
		body.set_meta("health", body.get_meta("health")-self.get_meta("damage")*alive)
		var dif = position - get_node("../Player").position
		self.apply_impulse(dif*10)
