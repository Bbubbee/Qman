extends Marker2D

const AIR_PARTICLES = preload("res://scenes/particles/air_particles.tscn")

func fire_particles():
	var air_particles = AIR_PARTICLES.instantiate()
	add_child(air_particles)
