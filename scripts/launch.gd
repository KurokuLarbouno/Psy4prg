extends Node2D
func _ready():
	get_node("Sprite/anim").play("open")
	set_fixed_process(true)
	set_process_input(true)
	pass
func _fixed_process(delta):
	pass
func _input(event):
	if (event.type == InputEvent.KEY||event.type == InputEvent.JOYSTICK_BUTTON||event.type == InputEvent.MOUSE_BUTTON):
		get_tree().change_scene("res://scene/Scene1.tscn")
	pass