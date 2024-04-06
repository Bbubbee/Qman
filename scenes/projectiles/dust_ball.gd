extends Projectile

func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation -= (delta * 50)


func destroy_self(): 
	Events.spawn_particles.emit(self.global_position, 10, self.direction)
	queue_free() 


func _on_destroy_timer_timeout():
	call_deferred("destroy_self")


func _on_hitbox_area_entered(_area):
	call_deferred("destroy_self")
