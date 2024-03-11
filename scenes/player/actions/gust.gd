extends Node2D
class_name Gust

@export var speed = 125.0
var direction: Vector2 
@onready var hitbox = $Hitbox
var force = 4000


func init(dir: Vector2, pos: Vector2): 
	self.direction = dir
	self.global_position = pos 

func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation = direction.angle()
	
	# Get collisions. 
	var bodies = hitbox.get_overlapping_bodies()
	#print(bodies)
	for i in bodies: 
		if i.collision_layer == 7:
			print(direction)
		
		var y = direction.y
		if y > 0: y = -y
		i.apply_force(Vector2(direction.x * force, y*force), -direction)
		print("body")
		print(i)
	
	
	


func _on_area_entered(_area: Area2D) -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
	pass

