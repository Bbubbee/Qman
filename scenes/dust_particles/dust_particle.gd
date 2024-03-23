extends RigidBody2D
class_name DustParticle

var direction: Vector2


func _ready() -> void:	
	if direction.x > 0: 
		direction.x = randf_range(direction.x, direction.x+200)
		self.position = self.position + Vector2(5, 0) 
	else: 
		direction.x = randf_range(direction.x, direction.x-200)
		self.position = self.position - Vector2(5, 0) 
		
		
	direction.y = randf_range(direction.y, direction.y-200)

	apply_impulse(direction, self.position)
	
