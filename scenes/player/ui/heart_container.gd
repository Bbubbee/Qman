extends HBoxContainer


const HEART = preload("res://scenes/player/ui/heart.tscn")

@export var health_component: HealthComponent

func _ready():
	health_component.sync_player_health.connect(init)

func init():
	if not health_component: return 
	
	# Get players health. 
	var counter = health_component.health
	for i in health_component.max_health: 
		if counter <= 0: 
			# This heart was already depleted. 
			add_depleted_heart()
		else: 
			add_child(HEART.instantiate())
		
		counter -= 1


# If the player has taken damage when transitioning scenes, 
# we need to spawn a player with a depleted heart. 
func add_depleted_heart(): 
	var depleted_heart = HEART.instantiate()
	add_child(depleted_heart)
	
	depleted_heart.spawn_depleted()

func deplete_heart(): 
	if not get_child_count():
		return 
	
	# Get the last heart and deplete it. 
	for i in range(get_child_count()-1, -1, -1 ):
		var heart = get_child(i) 
		if not heart.depleted: 
			heart.deplete_heart() 
			break
	
	
	
