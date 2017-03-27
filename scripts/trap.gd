extends Area2D


var t #---------------------------------timer
var body_save  #------------------------save enter body data
var owner#放置者
var trap_switch = false #---------------get or put
var trap_start = false #----------------讓陷阱放置完，等到放置者離開才會炸
var trap_restart = false #--------------陷阱重啟
var count = 0 #-------------------------count the exit times
func _ready():	
	set_fixed_process(true)
	t = 100000000
	connect("body_enter", self, "_on_trap_area_body_enter")#start signal
	pass
func _fixed_process(delta):
	t +=1
	if(t == 100):
#-------------------------------------trap effect reset
		body_save.player_sprite.set_modulate(Color(1.0,1.0,1.0))#trap effect
#-------------------------------------trap effect reset END

	if(t == 150):	#-----------------陷阱重新生成
		#randi()%4+1   <---4是生成點的編號(數量)
		get_node("../trap").set_pos(get_node("../generate_points"+str(randi()%4+1)).get_global_pos())
		t = 100000000
		count = 0
		trap_switch = false
		trap_start = false
		trap_restart = true

func _on_Area2D_body_enter( body ):
	for i in range(body.get_groups().size()):
			if(body.get_groups()[i]=="wall"):#crash wall
				t
			if(body.get_groups()[i]=="player_group"):#crash player
				#if(body.get_name() == "player"):
				#print(trap_start)
				if(!trap_switch):# get trap
					get_node("../trap").set_pos(get_node("../trash").get_global_pos())
					trap_switch = !trap_switch
					owner = body
					body.add_trap("trap")#---------把陷阱加入陷阱欄
				elif trap_start:
						body_save = body
						trap_switch = !trap_switch
						trap_start = false
					#trap effect
						body.player_sprite.set_modulate(Color(255.0,1.0,1.0))
					#trap effect END
						get_node("../trap").set_pos(get_node("../trash").get_global_pos())
						t=0
						count = 0
	pass # -----------------------------------------replace with function body


func _on_Area2D_body_exit( body ):
	
	if body == owner && count:
		trap_start = true
	if !trap_restart:
		#print(count)
		count += 1
	trap_restart = false
	pass # replace with function body

