extends KinematicBody2D
#-----------------------------------
#export:
#	MOTION_SPEED
#	BULLET_CHANGE_TME
#-----------------------------------
#---------------------------子彈部分
export var BULLET_QUANTITY = 10
var bulletQ#子彈數紀錄
export var BULLET_CHANGE_TME = 1
var bulletT#換彈時間紀錄
var prepared
#----------------------------------
#---------------------------陷阱部分
var bag_trap = []
var player_sprite
var putTrap_flag = false
#----------------------------------
#---------------------------移動部分
export var MOTION_SPEED = 140
var t
#---------------------------血量
export var health = 100
#----------------------------------
#----------------------------------死亡及無敵
var die = false
var TOGGLE_TIME = 0.1#閃爍頻率
var FLASH_TIME = 3#無敵時間
var ALIVE_TIME = 2#重生時間
var toggleT#閃爍時間紀錄
var flashT#無敵時間紀錄
var aliveT#重生時間紀錄
var visible_state = true

func _ready():
	
	reset()#-----------------------------------重置
	set_fixed_process(true)	#------------------設定loop
	player_sprite = get_node("player_Sprite")#-實現陷阱改player色效果
	
func _fixed_process(delta):
#-----------------------------------------------輸入狀態
	var shooting = false
	var reload = Input.is_action_pressed("ui_reload_P1")
#-----------------------------------------------移動	
	var motion = Vector2()
	
	if (Input.is_action_pressed("ui_up_2")):
		motion += Vector2(0, -1)
	if (Input.is_action_pressed("ui_down_2")):
		motion += Vector2(0, 1)
	if (Input.is_action_pressed("ui_left_2")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("ui_right_2")):
		motion += Vector2(1, 0)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	motion = move(motion)
	
	
	move(motion)
	
#-----------------------------------------------陷阱
	if (Input.is_action_pressed("putTrap")):
		
		if(!putTrap_flag):
			putTrap_flag = true
			if(bag_trap.size() != 0):
				#print(get_node("../tarp1"))
				
				#print(get_node("shootfrom").get_global_pos())
				get_node("../"+bag_trap[0]).set_pos(get_node("shootfrom").get_global_pos())
				bag_trap.remove ( 0 )
	if (!Input.is_action_pressed("putTrap")):
		putTrap_flag = false
#---------------------------------------------------	
#-----------------------------------------------牆壁碰撞	
	if is_colliding():
		move(motion*-0.1)
		if (Input.is_action_pressed("ui_up")):
			motion -= Vector2(0, -1)
			test_move (motion)
			if test_move (motion):
				motion += Vector2(0, -1)
			else:
				move(motion)
	
		if (Input.is_action_pressed("ui_down")):
			motion -= Vector2(0, 1)
		
			if test_move (motion):
				motion += Vector2(0, 1)
			else:
				move(motion)
			
		if (Input.is_action_pressed("ui_left")):
			motion -= Vector2(-1, 0)
			
			if test_move (motion):
				motion += Vector2(-1, 0)
			else:
				move(motion)
		if (Input.is_action_pressed("ui_right")):
			motion -= Vector2(1, 0)
			
			if test_move (motion):
				motion += Vector2(1, 0)
			else:
				move(motion)#killer_END
#------------------------------------------------------	
	# Make character slide nicely through the world
	var slide_attempts = 1
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1
	
#--------------------------------------------------------------子彈射擊
	t = delta
	
	if(shooting and prepared and bulletQ >= 0):#可發射狀態
		prepared = false
		var bullet = preload("res://scene/bullet.tscn").instance()
		bullet.set_pos(get_node("shootfrom").get_global_pos())
		get_node("../..").add_child(bullet)
		
		bulletQ -= 1#彈夾存入
		pass
	if(shooting != true):#放手才可再射
		if(bulletQ == 0): bulletQ = -1#進入倒數
		prepared = true#回復可發射狀態
		pass
	if(reload == true):
		bulletQ = -1
		pass
	if(bulletQ == -1):#裝彈倒數
		bulletT -= delta
		print(bulletT)
		if(bulletT <= 0):reload()#換彈
		pass
#---------------------------------------------------------------死亡
	if(die): die(delta)
#------------------------------------------------------------------





#---------------------------------------------------------------重置
func reset():
	prepared = true
	bulletQ = BULLET_QUANTITY
	bulletT = BULLET_CHANGE_TME
	flashT = FLASH_TIME
	toggleT = TOGGLE_TIME
	aliveT = ALIVE_TIME
	get_owner().health[1] = 100
	#self.set_pos()
	
	pass
#---------------------------------------------------------------換彈
func reload():
	prepared = true
	bulletQ = BULLET_QUANTITY
	bulletT = BULLET_CHANGE_TME
	pass
#---------------------------------------------------------------------
#--------------------------------------------------------------無敵
func die(delta):
	aliveT -= delta
	#-----死亡動作
	if(aliveT >= 0):
		flashT -= delta
		if(flashT >= 0):#閃爍時間
			toggleT -= delta
			if (toggleT <= 0 ):
				set_hidden(visible_state)
				visible_state = !visible_state
				toggleT = TOGGLE_TIME
				pass
		else: 
			set_hidden(false)
			visible_state = true
			die = false
			reset()
			pass
		pass
	pass
#----------------------------------------------------------------------
#--------------------------------------------------------------陷阱放置
func add_trap(trap_kind):
	bag_trap.append(trap_kind)
	pass
#---------------------------------------------------------------------
#--------------------------------------------------------------受擊
func hurt(var name):
	if(!die):
		get_owner().health[1] -= get_owner().bullet_ht
		pass
	if(get_owner().health[1] <= 0): die = true
	pass
#---------------------------------------------------------------------
