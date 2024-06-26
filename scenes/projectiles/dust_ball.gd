extends Projectile
class_name DustBall

@export var health: int = 1

## The amount of dust spawned on destroy. 
@export var dust: int = 10

func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation -= (delta * 50)



func _on_destroy_timer_timeout():
	Events.spawn_particles_generator(self.global_position, dust, self.direction)
	queue_free()


func _on_hitbox_area_entered(area):
	if area is Hitbox: 
		health -= area.damage 
	else:
		health -= 1
		
	if health <= 0: 
		Events.spawn_particles_generator(self.global_position, dust, self.direction)
		queue_free() 
	else:
		Events.spawn_particles_generator(self.global_position, dust/2, self.direction)
