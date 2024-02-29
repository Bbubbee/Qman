
extends Node2D

const DUST_PARTICLE = preload("res://scenes/dust_particles/dust_particle.tscn")


func _ready() -> void:
	# Connect spawn particle signal. 
	Events.spawn_particles.connect(_on_spawn_particles)


## Spawn a set amount of particles based on the count. 
func _on_spawn_particles(pos: Vector2, count: int, dir: Vector2): 
	for i in randi_range(count, (count+(count*0.4)) ):
		var dust = DUST_PARTICLE.instantiate()
		dust.position = pos		
		dust.direction = dir
		self.add_child(dust) 
