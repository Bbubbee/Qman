extends Node2D

@onready var player_detector: Area2D = $PlayerDetector
@onready var trap_doors = $TrapDoors
@onready var actors: Node2D = $Actors

"""
	Requirements: 
		- Instantiate this trap room in a level. 
		- Add trap door instances to TrapDoors. 
		- Add collider to PlayerDetector.
		- Add relevant actors to Actors. 
			- When all actors are defeated, the room will unlock. 
"""


func _ready() -> void:
	for actor in actors.get_children(): 
		if actor.has_signal("died"): 
			actor.died.connect(unlock_room)
		elif actor.has_signal("everyones_dead"):
			actor.everyones_dead.connect(unlock_room)
	
	for door in trap_doors.get_children(): 
		door.destroyed.connect(free_room)


## Checks if we should unlock the room. 
## This happens when all relevant actors are defeated. 
func unlock_room():	
	if actors.get_child_count()-1 <= 0: 		
		# Disable doors. 
		for door in trap_doors.get_children(): 
			door.disable()


## Once the room is unlocked, the doors can be destroyed. 
## Once all doors are destroyed, free the room. 
func free_room(): 
	if trap_doors.get_child_count()-1 <= 0: 	
		print("freeing room")	
		queue_free()


## Trap the player within the room once they touch the detector. 
func _on_player_detector_area_entered(_area):
	player_detector.queue_free()
	for door in trap_doors.get_children():
		door.spawn_door()

