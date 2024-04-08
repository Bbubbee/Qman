extends Node

"""
	Global Functions
"""


func get_distance_between_two_targets(a: Node2D, b: Node2D) -> float: 
	return (a.global_position - b.global_position).length()
