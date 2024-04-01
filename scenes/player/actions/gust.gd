extends Node2D
class_name Gust

@export var speed = 125.0
var direction: Vector2 
@onready var hitbox = $Hitbox
var force = 1500


func init(dir: Vector2, pos: Vector2): 
	# Shoot in a specific direction. 
	self.direction = dir
	self.global_position = pos 

func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation = direction.angle()
	
	# Blow back dust particles. 
	var bodies = hitbox.get_overlapping_bodies()
	for i in bodies:
		if i is DustParticle:
			# If the direction goes directly into the ground, 
			# flip it so it bounces up instead. 
			var y = direction.y
			if y > 0: y = -y
			
			i.apply_central_force(Vector2(direction.x*force, y*force))
	
	
	


func _on_area_entered(_area: Area2D) -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
	pass

