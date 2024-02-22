extends Node2D
class_name HealthComponent

@export var actor: Node2D
@export var max_health: float = 5.0
@onready var health: float = max_health


func take_damage(attack: AttackComponent): 
	# Damage the actor. 
	health -= attack.damage
	
	# Handle functionality of getting hit here, if exists. 
	# Usually this means transitioning into a damaged state. 
	if actor:
		if "attack_incoming" in actor: 
			actor.attack_incoming = attack
	
	# The actor has died. 
	if health <= 0: 
		# Handle death functionality here, if exists. 
		if "has_died" in actor: 
			actor.has_died = true
		
		# Free the actor if there is no funcionality for death. 
		else: 
			actor.queue_free()
			
