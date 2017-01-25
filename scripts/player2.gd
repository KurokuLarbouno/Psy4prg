extends KinematicBody2D

export var MOTION_SPEED = 140
var t
var RayNode 
var prepared = false

func _ready():
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
		RayNode.set_rot(0)
	if (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
		RayNode.set_rot(-90)
	if (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
		RayNode.set_rot(90)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	
	move(motion)
	
	#shoot
	t = delta
	if(shooting and prepared):
		prepared = false
		var bullet = preload("res://scene/bullet.tscn").instance()
		bullet.set_pos(get_node("shootfrom").get_global_pos())
		get_node("../..").add_child(bullet)

	if(shooting != true):
		prepared = true
	
	#trap
	var trap = preload("res://scene/trap.scn").instance()
	var area = preload("res://scene/player.tscn").instance()
	area = get_node("player_area")
	if(area.overlaps_area(trap)):
		motion += Vector2(10,0)