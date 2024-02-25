extends Node2D
class_name Gust

@export var speed = 125.0
var direction: Vector2 


func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation = direction.angle()


func _on_area_entered(_area: Area2D) -> void:
	queue_free()
