extends Node2D

@export var LEVEL: PackedScene
var current_level 


func _ready():
	current_level = LEVEL.instantiate()
	add_child(current_level)
	
	Events.start_level.connect(load_level)
	
	
func load_level(): 
	if current_level: current_level.queue_free()
	current_level = LEVEL.instantiate()
	add_child(current_level)
	


