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


