extends Projectile




func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation -= (delta * 50)



func _on_hurt_hit_box_area_entered(area: Area2D) -> void:
	Events.spawn_particles.emit(self.global_position, 10, self.direction)
	queue_free()
