extends Node

"""
	Global Functions
"""


func get_distance_between_two_targets(a: Node2D, b: Node2D) -> float: 
	return (a.global_position - b.global_position).length()

func get_direction_to_target(subject: Node2D, target: Node2D): 
	return (target.global_position - subject.global_position).normalized()

