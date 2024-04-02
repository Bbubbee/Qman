extends Marker2D

const AIR_PARTICLES = preload("res://scenes/particles/air_particles.tscn")

func fire_particles(size):
	var air_particles = AIR_PARTICLES.instantiate()
	air_particles.init(size)
	add_child(air_particles)
