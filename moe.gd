extends Node2D

# Godot Moe-Count-like Counter

var digits = [];

func _ready() -> void:
	for i in range(10):
		#nums.append(
		var digit = Sprite2D.new()
		
		digit.texture = load("res://" + get_meta("font_dir") + "/" +  str(i) + ".png")#tex
		digit.position = Vector2(200 + i*48,200)
		digit.scale = Vector2(2,2)
		digits.append(digit)
	
func set_num(x):
	for c in get_children():
		c.queue_free()
	
	self.position.x = (0 - 12 *len(str(x)))/2
	for i in range(len(str(x))):
		var d = digits[(int(str(x)[i]))].duplicate()
		d.position = Vector2(48*i,0)
		add_child(d)

func _process(delta: float) -> void:
	set_num(get_meta("value"))
