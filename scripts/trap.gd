extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var t
var QAQ
var ower
var collor
var trap_switch = false
func _ready():
	
	set_fixed_process(true)
	t = 10000
	connect("body_enter", self, "_on_trap_area_body_enter")
	
	pass
func _fixed_process(delta):
	t +=1
	if(t == 100):
		QAQ.player_sprite.set_modulate(Color(1.0,1.0,1.0))
		

func _on_trap_area_body_enter( body ):
	for i in range(body.get_groups().size()):
			if(body.get_groups()[i]=="wall"):
				t
			if(body.get_groups()[i]=="player_group"):
				#if(body.get_name() == "player"):
				print("crash")
				if(!trap_switch):
					trap_switch = !trap_switch
					ower = body
					get_node("../trap").set_pos(get_node("../trash").get_global_pos())
					
					body.add_trap("trap")
				else:
					if body != ower:
						QAQ = body
						body.player_sprite.set_modulate(Color(255.0,1.0,1.0))
						get_node("../trap").set_pos(get_node("../trash").get_global_pos())
						t=0
	pass # replace with function body
