
extends Node2D

const DUST_PARTICLE = preload("res://scenes/dust_particles/dust_particle.tscn")


func _ready() -> void:
	# Connect spawn particle signal. 
	Events.spawn_particles.connect(_on_spawn_particles)


func _on_spawn_particles(pos: Vector2): 
	print("Spawn particles")
	for i in randi_range(8, 15):
		print("spawning a dist")
		var dust = DUST_PARTICLE.instantiate()
		dust.position = pos + Vector2(i*5, 0) 		
		self.add_child(dust) 
