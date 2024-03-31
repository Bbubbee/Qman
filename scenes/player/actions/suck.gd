extends Node2D

@onready var area_2d = $Area2D
var force = 25
var is_sucking: bool = false
@onready var collection_zone = $CollectionZone


func suck(direction: Vector2): 
	var bodies = area_2d.get_overlapping_bodies()
	is_sucking = true
	for i in bodies: 
		i.apply_central_force(-(direction*force))






func _on_collection_zone_body_entered(body):
	body.queue_free()
