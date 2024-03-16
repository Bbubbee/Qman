extends Camera2D

#var zoom_in: bool = false
#var zoom_speed = Vector2(0.1, 0.1)
#
#func _ready() -> void:
	#Events.player_died.connect(player_died) 
#
#
#func _physics_process(delta: float) -> void:
	#zoom += zoom_speed * delta
	#return
	## Zoom in towards player. 
	#if zoom_in:
		#while zoom <= Vector2(2, 2):
			#zoom += zoom_speed * delta
#
#func player_died(): 
	#return 
	#zoom_in = true
	#return
	#while zoom <= Vector2(2, 2):
		#print(zoom)
		#zoom += zoom_speed

	#zoom_in = true
