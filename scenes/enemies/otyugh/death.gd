extends State


func enter(_enter_params = null):
	call_deferred("die")


func die(): 
	Events.explode_dust_particles.emit(actor.position, 70)
	actor.queue_free()
