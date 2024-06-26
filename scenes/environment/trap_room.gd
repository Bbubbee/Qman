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


## Connect all the signals required for the trap room to operate. 
func _ready() -> void:
	for actor in actors.get_children(): 
		if actor.has_signal("died"): 
			actor.died.connect(unlock_room_check)
		elif actor.has_signal("everyones_defeated"):
			actor.everyones_defeated.connect(unlock_room_check)
	
	for door in trap_doors.get_children(): 
		door.destroyed.connect(free_room)


## Checks if we should unlock the room. 
## This happens when all relevant actors are defeated. 
func unlock_room_check():	
	if not actors.get_child_count()-1 <= 0: return		
	
	unlock_room()
	
func unlock_room(): 
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
	
	spawn_actors()


func spawn_actors(): 
	for actor in actors.get_children():
		if actor.has_method("spawn"):
			actor.spawn()

