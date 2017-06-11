extends Area2D

var t#timer
var body_save # save enter body data
var owner#放置者
var trap_switch = false#get or put
var trap_start = false#讓陷阱放置完，等到放置者離開才會炸
var trap_restart = false#陷阱重啟
var player_putdown_trap_flag = false#使用者是否放置陷阱還是再切換中flag 切換中true
var remove_index = []#for remove generate_points_num
var self_generate_points_num #此陷阱生成點編號
var count = 0 #count the exit times
var random_num #隨機變數
var red_time#變紅時間
var slow_time#變慢時間
var random_num_flag = false#隨機變數flag
var image = load("res://image/banana.png")#香蕉(trap1)圖
var image2 = load("res://image/banana.png")#圖
func _ready():
	if self.get_name() == "trap1":
		self.get_child(0).set_texture(image)
		
	set_fixed_process(true)
	slow_time = 100000000
	t = 100000000
	red_time = 100000000
	connect("body_enter", self, "_on_trap_area_body_enter")#start signal
	connect("body_exit", self, "_on_trap_body_exit")#start signal
	pass
func _fixed_process(delta):
	
	t +=delta
	red_time +=1
	slow_time += delta
#-----------------------------------------陷阱效果reset
	if(red_time <= 20):
	#trap effect reset
		body_save.player_sprite.set_modulate(Color(255/(12.75*red_time),1.0,1.0))#trap effect
	
	if slow_time >= 3 and slow_time < 4:#變慢復原
		body_save.MOTION_SPEED = 140
	#trap effect reset END
#-----------------------------------------陷阱效果reset END
	if(t >= 5 && t<6):#陷阱重新生成
		
		
		#randi()%4+1   <---4是生成點的編號(數量)
		while(1):#禁止重複
			random_num = str( randi()%4+1 )
			#generate_points_num.append(  )
			random_num_flag = false
			
			for index in range(get_parent().get_parent().generate_points_num.size()):
				
				if int(get_parent().get_parent().generate_points_num[index]) == int(random_num) : 
					random_num_flag = true				
			if ! random_num_flag : break
		get_parent().get_parent().generate_points_num.append( random_num )

		
		self.set_gravity( int(random_num) )
		self.set_pos(get_node("../generate_points"+random_num).get_global_pos())
		t = 100000000
		red_time = 100000000
		slow_time = 100000000
		count = 0
		trap_switch = false
		trap_start = false
		trap_restart = true
func _on_trap_area_body_enter( body ):
	#print(self.get_name())
	if !player_putdown_trap_flag:
		for i in range(body.get_groups().size()):
				if(body.get_groups()[i]=="wall"):#crash wall
					t
				if(body.get_groups()[i]=="player_group"):#crash player
					#if(body.get_name() == "player"):
					if(!trap_switch):# get trap
						self.set_pos(get_node("../trash").get_global_pos())
						trap_switch = !trap_switch
						owner = body
						
						self_generate_points_num = self.get_gravity()
						for index in range(get_parent().get_parent().generate_points_num.size()):
							if int(get_parent().get_parent().generate_points_num[index]) == int(self_generate_points_num) : 
								remove_index.append(index)
								
						for index in range(remove_index.size()):
							get_parent().get_parent().generate_points_num.remove ( remove_index[0] )
							remove_index.remove(0)
						#從生成點編號陣列中去除 END
						body.add_trap(self.get_name())#把陷阱加入陷阱欄
					else:
						if trap_start:
							body_save = body
							trap_switch = !trap_switch
							trap_start = false
#-----------------------------------------trap effect 陷阱效果發生區
							body.player_sprite.set_modulate(Color(255.0,1.0,1.0))
							if self.get_name() == "trap":
								slow_time = 0
								body.MOTION_SPEED = 70
#-------------------------------陷阱的扣血(嘔吐物？)								
								if body.get_name() == "player":
									get_parent().get_parent().health[0] -= 5
								if body.get_name() == "player_null":
									get_parent().get_parent().health[1] -= 5
#-------------------------------陷阱的扣血(嘔吐物？) END
							if self.get_name() == "trap1":
								body.banana_trap_effect_flag = true
#-----------------------------------------trap effect END
							self.set_pos(get_node("../trash").get_global_pos())
							t=0
							red_time = 0
							count = 0
	pass # replace with function body


func _on_trap_body_exit( body ):
	if !player_putdown_trap_flag:
#----------------------------------------此段控制是否是否玩家一觸即發trap
		trap_start = true#
		#if body == owner && count:
		#	trap_start = true
#----------------------------------------
		if !trap_restart:
		
			count += 1
		trap_restart = false
	pass #replace with function body
