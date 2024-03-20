extends Node2D

var is_sucking: bool = false
@onready var area_2d = $Area2D
var force = 15


func suck(direction: Vector2, position: Vector2): 
	var bodies = area_2d.get_overlapping_bodies()
	for i in bodies: 
		i.apply_force(direction, -position)
