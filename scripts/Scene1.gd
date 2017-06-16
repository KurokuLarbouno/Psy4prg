extends Node2D
var str_curBtn
var bool_btn1 = 0
var bool_btn2 = 0
var bool_btn3 = 0
var bool_btn4 = 0

func _input(event):
	# Handle the first pressed key
	if (event.type == InputEvent.KEY):
		get_node("Button1/AnimationPlayer").play("stop")
		get_node("Button2/AnimationPlayer").play("stop")
		binding(0, event.device)
		set_process_input(false)
	if (event.type == InputEvent.JOYSTICK_BUTTON):
		get_node("Button1/AnimationPlayer").play("stop")
		get_node("Button2/AnimationPlayer").play("stop")
		#print(event.device)
		binding(1, event.device)
		set_process_input(false)

func binding(kind, device):
	if(str_curBtn == "Button1"): 
		global.input_kind[0]=kind
		global.input_device[0]=device
		if(kind):
			get_node("joystick1").set_hidden(false)
			for x in range(4): get_node("joystick1").get_node("p"+str(x+1)).set_hidden(true)
			get_node("joystick1").get_node("p"+str(device+1)).set_hidden(false)
			get_node("mouse1").set_hidden(true)
		else:
			for x in range(4): get_node("joystick1").get_node("p"+str(x+1)).set_hidden(true)
			get_node("joystick1").get_node("p"+str(device+1)).set_hidden(false)
			get_node("joystick1").set_hidden(true)
			get_node("mouse1").set_hidden(false)
	if(str_curBtn == "Button2"): 
		global.input_kind[1]=kind
		global.input_device[1]=device
		if(kind):
			get_node("joystick2").set_hidden(false)
			for x in range(4): get_node("joystick2").get_node("p"+str(x+1)).set_hidden(true)
			get_node("joystick2").get_node("p"+str(device+1)).set_hidden(false)
			get_node("mouse2").set_hidden(true)
		else:
			get_node("joystick2").set_hidden(false)
			for x in range(4): get_node("joystick2").get_node("p"+str(x+1)).set_hidden(true)
			get_node("joystick2").set_hidden(true)
			get_node("mouse2").set_hidden(false)
	pass

func _ready():
	#動畫
	get_node("Slide").play("slide")
	var str_ik = []#輸入型態暫存
	#綁定callback
	for x in range(global.player_amount):
		get_node("Button"+str(x+1)).connect("pressed", self, "_on_Button"+str(x+1)+"_pressed")
	get_node("Button_Send").connect("pressed", self, "_on_Send_pressed")
	#填入預設值
	if(global.player.size()==0):
		for x in range(global.player_amount):
			global.player.append(0)
			global.input_device.append(0)
			global.input_kind.append(0)
	
	#預設值/已存值顯示
	for x in range(global.player_amount):
		if(global.input_kind[x]): 
			str_ik.append("JOYSTICK")
			get_node("joystick"+str(x+1)).set_hidden(false)
			get_node("mouse"+str(x+1)).set_hidden(true)
		else: 
			str_ik.append("KEYBOARD")
			get_node("joystick"+str(x+1)).set_hidden(true)
			get_node("mouse"+str(x+1)).set_hidden(false)
#	set_fixed_process(true)	#------------------設定loop
	pass

func _fixed_process(delta):
	pass

func _on_Button1_pressed():
	get_node("Button2/AnimationPlayer").play("stop")
	get_node("Button1/AnimationPlayer").play("flash")
	bool_btn1 = !bool_btn1				#切換 玩/不玩
	global.player[0] = bool_btn1		#填入global
	str_curBtn = "Button1"				#填入暫存
	set_process_input(true)				#註冊事件
	pass # replace with function body


func _on_Button2_pressed():
	get_node("Button1/AnimationPlayer").play("stop")
	get_node("Button2/AnimationPlayer").play("flash")
	bool_btn2 = !bool_btn2
	global.player[1] = bool_btn2
	str_curBtn = "Button2"
	set_process_input(true)
	pass # replace with function body

func _on_Button3_pressed():
	bool_btn3 = !bool_btn3
	global.player[2] = bool_btn3
	str_curBtn = "Button3"
	set_process_input(true)
	pass # replace with function body

func _on_Button4_pressed():
	bool_btn4 = !bool_btn4
	global.player[3] = bool_btn4
	str_curBtn = "Button4"
	set_process_input(true)
	pass # replace with function body

func _on_Send_pressed():
	if (global.input_kind.count(0)<2):
		get_tree().change_scene("res://scene/game.scn")
	pass # replace with function body