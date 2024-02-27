extends Node2D
class_name HealthComponent

## Prerequisites: 
## 	- An actor with means to handle the handle_attack signal. 

@export var actor: Node2D
@export var max_health: float = 5.0
@onready var health: float = max_health

signal handle_attack(attack: Hitbox, has_died: bool)


func take_damage(attack: Hitbox): 
	health -= attack.damage
	
	# Handle the direction of knockback. 
	var direction = (actor.global_position - attack.global_position).normalized()
	attack.direction = direction
	print(direction)
	
	if health >= 0: 
		handle_attack.emit(attack, false)
	else: 
		handle_attack.emit(attack, true)

			
