extends RigidBody2D

# Basic AI, goomba-like
func _ready() -> void:
	get_node("AnimationPlayer2").current_animation = "float"

var dir = 1
var alive = 1;

const particles = preload("res://ketchup_explode.tscn")

func _on_top_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var p = particles.instantiate()
		p.global_position = global_position + Vector2(0,-50)
		get_node("..").add_child(p)
		body.set_meta("score", (body.get_meta("score")+300))
		body.apply_impulse(Vector2(0,-body.linear_velocity.y *1.5))
		alive = 0
		self.queue_free() # TODO: Animate

func _physics_process(delta: float) -> void:
	self.apply_force(Vector2(dir* self.get_meta("speed"), 0))

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	self.queue_free()


func _on_fall_l_body_exited(body: Node2D) -> void:
	if body.name == "TileMapLayer":
		dir = -1


func _on_fall_r_body_exited(body: Node2D) -> void:
	if body.name == "TileMapLayer":
		dir = 1


func _on_eside_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		dir = -dir #turn around
		body.set_meta("health", body.get_meta("health")-self.get_meta("damage")*alive)
		body.set_meta("score", (body.get_meta("score")-100))
