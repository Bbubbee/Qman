extends Sprite2D





func _on_health_component_handle_attack(attack, _has_died):
	call_deferred("spawn_particles", attack)
	queue_free()

func spawn_particles(attack): 
	Globals.play_hurt_sfx(self.global_position)
	Events.spawn_particles.emit(self.global_position, 10, attack.direction)		
