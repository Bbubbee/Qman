extends State

var direction


func enter(_enter_params = null):
	actor.animator.play("death")
	direction = _enter_params.direction
	actor.call_deferred("disable_hitbox")
	actor.call_deferred("spawn_particles", 10, direction)		
		

func _on_animator_animation_finished(anim_name: StringName) -> void:	
	if anim_name == "death": 
		actor.died.emit()				
		actor.queue_free()
		
		
		
