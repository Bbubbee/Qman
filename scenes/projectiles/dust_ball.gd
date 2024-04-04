extends Projectile



func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation -= (delta * 50)


func spawn_particles():
	Events.spawn_particles.emit(self.global_position, 10, self.direction)
	queue_free()

