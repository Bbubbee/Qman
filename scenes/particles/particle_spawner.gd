
extends Node2D

const DUST_PARTICLE = preload("res://scenes/dust_particles/dust_particle.tscn")
const DUST_PARTICLE_V2 = preload("res://scenes/dust_particles/dust_particle_v_2.tscn")


func _ready() -> void:
	# Connect spawn particle signal. 
	Events.spawn_particles.connect(_on_spawn_particles)
	Events.explode_dust_particles.connect(_on_explode_dust_particles)
	
func _on_explode_dust_particles(pos: Vector2, count: int): 
	for i in randi_range(count, int((count+(count*0.4))) ):
		# Generate random direction in 360 degrees. 

		var random_angle = randf_range(0, 2 * PI) # Generate a random angle between 0 and 2*pi (360 degrees)
		var direction = Vector2(cos(random_angle), sin(random_angle))
		
		var dust = DUST_PARTICLE_V2.instantiate()
		dust.position = pos		
		dust.direction = direction		
		self.add_child(dust) 

## Spawn a set amount of particles based on the count. 
func _on_spawn_particles(pos: Vector2, count: int, dir: Vector2): 
	for i in randi_range(count, int((count+(count*0.4))) ):
		var dust = DUST_PARTICLE.instantiate()
		dust.position = pos		
		dust.direction = dir
		self.add_child(dust) 


