extends Node

func _ready():
	Events.start_level.connect(reset_player_stats) 

func reset_player_stats(): 
	health = max_health
	dust_particles = 0
	
# Health
var max_health: int = 4
@onready var health: int = max_health
signal health_changed
var heal_cost: int = 50
func can_heal(): 
	if dust_particles >= heal_cost: return true
	else: return false

# Dust Particles. 
signal dust_particles_changed 
var max_dust_particles: int = 100
var dust_particles: int = 0:
	set(val):
		dust_particles = clamp(val, 0, max_dust_particles)
		emit_signal("dust_particles_changed", dust_particles)

# Attacks. 
var attack_dmg: float = 1
var charge_attack_dmg: float = 2
var attack_knockback_force: float = 205
var charge_attack_knockback_force: float = 405
var attack_knockback_force_enemy: float = 200
var charge_attack_knockback_force_enemy: float = 325
var charge_attack_cost: int = 35
func can_charge_attack() -> bool: 
	if dust_particles >= charge_attack_cost: 
		return true
	else: 
		return false
