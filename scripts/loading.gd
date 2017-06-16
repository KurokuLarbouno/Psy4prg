extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var t = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("Sprite/AnimationPlayer").play("loading")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	t += 1
	if(t > 300 ):
		get_tree().change_scene("res://scene/launch.tscn")