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
			actor.died.connect(check_if_room_is_cleared)
		elif actor.has_signal("everyones_dead"):
			actor.everyones_dead.connect(check_if_room_is_cleared)


func check_if_room_is_cleared():
	print("i died")
	
	if actors.get_child_count()-1 <= 0: 
		queue_free()


## Trap the player within the room once they touch the detector. 
func _on_player_detector_area_entered(_area):
	player_detector.queue_free()
	for door in trap_doors.get_children():
		door.spawn_door()

