extends KinematicBody2D

export var MOTION_SPEED = 140
var t
var RayNode 
var player_sprite
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
	if (Input.is_action_pressed("ui_down")):
		motion += Vector2(0, 1)
	if (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
<<<<<<< HEAD
	
	motion = motion.normalized()*MOTION_SPEED*delta
	motion = move(motion)
=======
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
>>>>>>> origin/master
	
	# Make character slide nicely through the world
	var slide_attempts = 1
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1
	
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





func _on_tarp_area_enter( area ):
	print("hi")
	pass # replace with function body


func _on_tarp_area_exit( area ):
	print("hi")
	pass # replace with function body


func _on_tarp_body_enter( body ):
	print("hi")
	pass # replace with function body
