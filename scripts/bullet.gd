extends Area2D

var sp = 100
var a  = 0
var motion = Vector2()
var speedup = Input.is_action_pressed("speedup")
var speeddown = Input.is_action_pressed("speeddown")
var t = 0
var owner_name#-----------------------------------儲存發射者名

func _ready():
	set_fixed_process(true)
	t = 0
	sp = get_parent().bullet_sp#-----------------找到game.scene節點
	sp = 200
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
		if(body.get_groups()[i]=="player_group"):
			if(body.get_name() != owner_name):
				t=1000#結束子彈
				body.hurt(get_node("../floor/"+owner_name).bullet_dmg)
	pass
	
func set_owner(var owname):
	owner_name = owname
	pass
