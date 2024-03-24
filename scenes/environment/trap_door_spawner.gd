extends Node2D

@onready var trap_doors = $TrapDoors


func _on_player_detector_area_entered(area):
	$PlayerDetector.queue_free()
	for door in trap_doors.get_children():
		door.spawn_door()
