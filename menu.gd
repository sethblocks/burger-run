extends Button


func _on_pressed_play() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func exitg():
	get_tree().quit()



var yes_buttons = [
	"Yep",
	"I guess so",
	"Why not",
	"True",
	"Absolutely",
	"Yes Father",
	"I mean, sure, but it's not like I WANT to"
]

var no_buttons = [
	"nuh uh",
	"Nope",
	"no",
	"No way Jose",
	"Hell naw",
	"Sybau"
]

func _on_button_2_pressed() -> void:
	var dialog = AcceptDialog.new()
	dialog.dialog_text = "You trynna leave already?"
	dialog.title = "trynna leave?"
	dialog.ok_button_text = yes_buttons[randi_range(0,len(yes_buttons)-1)]
	dialog.add_cancel_button(no_buttons[randi_range(0,len(no_buttons)-1)])
	add_child(dialog)
	dialog.popup_centered()
	dialog.confirmed.connect(exitg)
	pass # Replace with function body.
