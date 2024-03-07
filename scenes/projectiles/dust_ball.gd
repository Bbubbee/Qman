extends Projectile


@onready var hurt_hit_box: HurtHitBox = $HurtHitBox


func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation -= (delta * 50)



func _on_hurt_hit_box_area_entered(_area: Area2D) -> void:
	#set_deferred("monitoring", false)
	#set_deferred("monitorablemo", false)
	
	#hurt_hit_box.monitorable = false
	#hurt_hit_box.monitoring = false
	
	call_deferred("spawn_particles", self.global_position, 10, self.direction)
	queue_free()


func spawn_particles(pos, amount, dir):
	Events.spawn_particles.emit(pos, amount, dir)
