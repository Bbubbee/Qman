extends State

var direction


func enter(_enter_params = null):
	direction = _enter_params.direction
	actor.call_deferred("disable_hitbox")
	actor.call_deferred("spawn_particles", 10, direction)
	call_deferred("die")

func die(): 
	actor.died.emit()				
	actor.queue_free()

		
		
		
		
