extends Node


var max_health: int = 4
@onready var health: int = max_health

func _ready():
	Events.start_level.connect(reset_player_health) 
	
func reset_player_health(): 
	health = max_health
