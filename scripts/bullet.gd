extends Area2D


export var sp = 60
var a 
var motion = Vector2()
var speedup = Input.is_action_pressed("speedup")
var speeddown = Input.is_action_pressed("speeddown")
var t = 0
func _ready():
	set_fixed_process(true)
	a= -atan2((get_global_mouse_pos().x -  get_pos().x),(get_global_mouse_pos().y -  get_pos().y))
	a = a + PI/2
	t = 0
func _fixed_process(delta):
	motion = Vector2(cos(a)*sp*delta, sin(a)*sp*delta)
	translate(motion)
	if(speedup):
		sp = 100
	if(speeddown):
		sp = 30
	t +=1
	
	if(t>1000):
		self.free()