extends Node2D
class_name Projectile


@export var speed = 125.0
var direction: Vector2 


func init(dir: Vector2, pos: Vector2): 
	self.direction = dir
	self.global_position = pos 
	

func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation = direction.angle()
	
#
#func _on_area_entered(_area: Area2D) -> void:
	#queue_free()
#
#
#func _on_timer_timeout() -> void:
	#queue_free()
	

