extends Node


signal player_died() 
signal start_level()
signal screen_shake()


## Handle Dust Particles. 

signal explode_dust_particles(pos: Vector2, count: int) 

signal spawn_particles(pos: Vector2, count: int, dir: Vector2)

func spawn_particles_generator(pos, count, dir): 
	call_deferred("spawn_particles_generator_assist", pos, count, dir)
	
func spawn_particles_generator_assist(pos, count, dir): 
	spawn_particles.emit(pos, count, dir)


