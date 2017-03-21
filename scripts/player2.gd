extends KinematicBody2D
#---------------------------子彈部分
export var BULLET_QUANTITY = 5
var bulletQ
export var BULLET_CHANGE_TME = 5
var bulletT
#----------------------------------
export var MOTION_SPEED = 140
var t
var RayNode 
var player_sprite
var prepared
func _ready():
	#---------------------------------
	bulletQ = BULLET_QUANTITY
	bulletT = BULLET_CHANGE_TME
	prepared = true
	#----------------------------------
	set_fixed_process(true)
	RayNode = get_node("RayCast2D")
	
func _fixed_process(delta):
	
	var shooting = Input.is_action_pressed("shoot")
	
	var motion = Vector2()

	#motion
	
	if (Input.is_action_pressed("ui_up")):
		motion += Vector2(0, -1)
		RayNode.set_rotd(180)
	if (Input.is_action_pressed("ui_down")):
		motion += Vector2(0, 1)
		RayNode.set_rotd(0)
	if (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
		RayNode.set_rot(-90)
	if (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
		RayNode.set_rot(90)
	

	move(motion)
	if is_colliding():#killer
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
	#shoot
	t = delta
	
	
	if(shooting and prepared and bulletQ >= 0):#---------------可發射狀態
		prepared = false
		var bullet = preload("res://scene/bullet.tscn").instance()
		bullet.set_pos(get_node("shootfrom").get_global_pos())
		get_node("../..").add_child(bullet)
		
		bulletQ -= 1#------------------------------------------彈夾存入
		pass
	if(shooting != true):#-------------------------------------放手才可再射
		if(bulletQ == 0): bulletQ = -1#------------------------進入倒數
		if(bulletT <= 0):reset()#------------------------------重置
		prepared = true#---------------------------------------回復可發射狀態
		pass
	
	if(bulletQ == -1):#----------------------------------------裝彈倒數
		bulletT -= delta
		pass
	
	
	#trap
	var trap = preload("res://scene/trap.scn").instance()
	var area = preload("res://scene/player.tscn").instance()
	area = get_node("player_area")
	if(area.overlaps_area(trap)):
		motion += Vector2(10,0)
		
	pass

func reset():
	prepared = true
	bulletQ = BULLET_QUANTITY
	bulletT = BULLET_CHANGE_TME
	pass