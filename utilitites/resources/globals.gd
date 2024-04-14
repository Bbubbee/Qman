extends Node

"""
	Global Functions
"""


func get_distance_between_two_targets(a: Node2D, b: Node2D) -> float: 
	return (a.global_position - b.global_position).length()

func get_direction_to_target(subject: Node2D, target: Node2D): 
	return (target.global_position - subject.global_position).normalized()

func get_height_difference(subject: Node2D, target: Node2D):
	return subject.global_position.y - target.global_position.y 

func play_sound_effect(pos: Vector2, sfx: AudioStreamPlayer2D):
	sfx.global_position = pos 
	get_tree().current_scene.add_child(sfx)
	sfx.play()

const hurt_sfx = preload("res://scenes/audio/hit.tscn")
func play_hurt_sfx(pos: Vector2): 
	var sfx = hurt_sfx.instantiate()
	sfx.global_position = pos 
	get_tree().current_scene.add_child(sfx)
	sfx.play()

const explosion_sfx = preload("res://scenes/audio/explosion_sfx.tscn")
func play_explosion_sfx(pos: Vector2): 
	var sfx = explosion_sfx.instantiate()
	sfx.global_position = pos 
	get_tree().current_scene.add_child(sfx)
	sfx.play()

const zap = preload("res://scenes/audio/zap.tscn")
func play_zap_sfx(): 
	var sfx = zap.instantiate()
	get_tree().current_scene.add_child(sfx)
	sfx.play()
