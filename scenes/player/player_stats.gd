extends Node

func _ready():
	Events.start_level.connect(reset_player_stats) 

func reset_player_stats(): 
	health = max_health
	dust_particles = 0
	
# Health
var max_health: int = 4
@onready var health: int = max_health

# Dust sucked. 
signal dust_particles_changed 
var max_dust_particles: int = 100
var dust_particles: int = 0:
	set(val):
		dust_particles = clamp(val, 0, max_dust_particles)
		emit_signal("dust_particles_changed", dust_particles)

var attack_dmg: float = 1
var charge_attack_dmg: float = 2
var attack_knockback_force_enemy: float = 200
var charge_attack_knockback_force_enemy: float = 325
func can_charge_attack() -> bool: 
	if dust_particles >= 40: 
		return true
	else: 
		return false
