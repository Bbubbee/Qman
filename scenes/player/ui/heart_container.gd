extends HBoxContainer


const HEART = preload("res://scenes/player/ui/heart.tscn")

@export var health_component: HealthComponent

func _ready():
	if not health_component: return 
	
	# Get players health. 
	for i in health_component.health: 
		add_child(HEART.instantiate())


func deplete_heart(): 
	if not get_child_count():
		return 
	
	# Get the last heart and deplete it. 
	
	for i in range(get_child_count()-1, -1, -1 ):
		var heart = get_child(i) 
		if not heart.depleted: 
			heart.deplete_heart() 
			break
	
	
	
