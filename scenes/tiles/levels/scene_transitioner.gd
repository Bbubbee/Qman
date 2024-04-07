extends Node2D


@export var scene_to_go_to: PackedScene


func _on_area_2d_area_entered(_area: Area2D) -> void:
	get_tree().change_scene_to_packed(scene_to_go_to)
	
	#call_deferred("change_scenes")


func change_scenes():	
	get_tree().change_scene_to_packed(scene_to_go_to)
	
