extends Node2D
func _ready():
	set_fixed_process(true)
	pass
func _fixed_process(delta):
	#P1 health
	#get_node("Label_Health").set_text("")
	if (get_owner().health[1]==50):
		get_node("HP1").set_hidden(1)
	elif(get_owner().health[1]==0):
		get_node("HP2").set_hidden(1)
	if(get_owner().revive==true):
		print(456456456)
		get_node("HP1").set_hidden(0)
		get_node("HP2").set_hidden(0)
		get_owner().revive=false
	pass


