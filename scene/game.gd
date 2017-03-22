extends Node2D


var bullet_sp = 60
var is_clicked = false

func _ready():
	set_fixed_process(true)
	pass
func _fixed_process(delta):
	if(Input.is_action_pressed("speedup")):bullet_sp = 200
	if(Input.is_action_pressed("speeddown")):bullet_sp = 30
	
	pass