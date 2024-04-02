extends Node

func _ready():
	Events.start_level.connect(reset_player_stats) 
	
# Health
var max_health: int = 4
@onready var health: int = max_health

func reset_player_stats(): 
	health = max_health
	dust_particles = 0 
	

# Dust sucked. 
signal dust_particles_changed 
var max_dust_particles: int = 100
var dust_particles: int = 0:
	set(val):
		dust_particles = clamp(val, 0, max_dust_particles)
		emit_signal("dust_particles_changed", dust_particles)

func can_charge_attack() -> bool: 
	if dust_particles >= 40: 
		return true
	else: 
		return false