extends Node2D

const PLAYER = preload("res://scenes/player/player.tscn")

func _ready():
	add_child(PLAYER.instantiate())
	Events.start_level.connect(spawn_player)


## When the respawn button is pressed, respawn the player. 
func spawn_player(): 
	if self.get_child_count() > 0: 
		self.get_child(0).queue_free()
	add_child(PLAYER.instantiate())


	
