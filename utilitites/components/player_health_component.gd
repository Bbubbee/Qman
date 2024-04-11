extends HealthComponent


## Prerequisites: 
## 	- An actor with means to handle the handle_attack signal. 


signal sync_player_health


func init(hp, max_hp): 
	self.health = hp
	self.max_health = max_hp 
	sync_player_health.emit()

signal heal_heart
func heal(): 
	if health >= max_health: return 
	var new_health = clamp(health+1, 0, max_health)
	health = new_health
	PlayerStats.health = new_health
	heal_heart.emit()

signal deplete_heart
func take_damage(attack: Hitbox): 
	handle_invulnerability(attack)
	
	# Handle the direction of knockback. 
	var direction = (actor.global_position - attack.global_position).normalized()
	attack.direction = direction
	
	# Sync Heart UI. 
	
	
	# Signal to the actor that they have taken damage. 
	# They may have more take damage functionality to implement. 
	if health > 0: 
		handle_attack.emit(attack, false)
	# Signal to the actor that they have died. 
	# They may have more take death functionality to implement. 
	else: 
		handle_attack.emit(attack, true)


## In the case the actor has a variable "is_invulnerable" and it is true, 
## they will not take damage during this attack. 
func handle_invulnerability(attack: Hitbox): 
	if "is_invulnerable" in actor: 
		if not actor.is_invulnerable: 
			PlayerStats.health -= 1
			health -= attack.damage
			deplete_heart.emit()
			
	else: 
		health -= attack.damage
		PlayerStats.health -= 1
		deplete_heart.emit()
		
	

			
