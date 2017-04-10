extends ParallaxBackground
var string

func _ready():
	get_node("Label_Health").set_text("")
	set_fixed_process(true)
	pass
func _fixed_process(delta):
	get_node("Label_Health").set_text("")
	
	for index in range(get_owner().health.size()):
		set_Health(index, get_owner().health[index])
		pass
	
	pass
func set_Health(player, health):
	string = get_node("Label_Health").get_text()
	get_node("Label_Health").set_text(string + str(player) + ": " + str(health) + "\n")
	pass