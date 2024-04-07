extends Node2D


func _ready():
	Events.start_level.connect(load_level)
	

func load_level(): 
	get_tree().reload_current_scene() 

