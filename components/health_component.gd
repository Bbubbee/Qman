extends Node2D
class_name HealthComponent

@export var actor: Node2D
@export var max_health: float = 5.0
@onready var health: float = max_health


func take_damage(attack: AttackComponent): 
	health -= attack.damage
	
	if actor:
		if "attack_incoming" in actor: 
			actor.attack_incoming = attack
	
	if health <= 0: 
		actor.queue_free()
