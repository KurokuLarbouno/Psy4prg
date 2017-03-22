extends Area2D

export var sp = 60
var a 
var motion = Vector2()
var speedup = Input.is_action_pressed("speedup")
var speeddown = Input.is_action_pressed("speeddown")
var t = 0

func _ready():
	set_fixed_process(true)
	a= -atan2((get_global_mouse_pos().x -  get_pos().x),(get_global_mouse_pos().y -  get_pos().y))#確定發射角度
	a = a + PI/2
	t = 0
	sp = get_parent().bullet_sp#-----------------找到game.scene節點
func _fixed_process(delta):
	motion = Vector2(cos(a)*sp*delta, sin(a)*sp*delta)
	translate(motion)
	t +=1
	
	if(t>1000):
		self.free()
func _on_bullet_body_enter( body ):
	
	for i in range(body.get_groups().size()):
		if(body.get_groups()[i]=="wall"):
			t=1000#結束子彈
		if(body.get_groups()[i]=="player"):
			body.hit(self)
			t=1000#結束子彈
	
	pass # replace with function body
