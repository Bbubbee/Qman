extends Node2D

@onready var trap_doors = $TrapDoors

"""
	Requirements: 
		- Instantiate this trap room in a level. 
		- Add trap door instances to TrapDoors. 
		- Add collider to PlayerDetector.
		- Add relevant actors to Actors. 
			- When all actors are defeated, the room will unlock. 
"""

## Trap the player within the room once they touch the detector. 
func _on_player_detector_area_entered(_area):
	$PlayerDetector.queue_free()
	for door in trap_doors.get_children():
		door.spawn_door()


"""
	Find a way to see if the requirements are met for the player to leave. 
	
	1. Could spawn all the actors in the room. When they are all defeated, 
	unlock the room. 
		- What if there are other ways of leaving the room? Deal with it then. 
"""

