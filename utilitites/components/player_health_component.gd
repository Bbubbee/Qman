extends HealthComponent


## Prerequisites: 
## 	- An actor with means to handle the handle_attack signal. 


signal sync_player_health


func init(health, max_health): 
	self.health = health
	self.max_health = max_health 
	sync_player_health.emit()

func take_damage(attack: Hitbox): 
	handle_invulnerability(attack)
	
	# Handle the direction of knockback. 
	var direction = (actor.global_position - attack.global_position).normalized()
	attack.direction = direction
	
	# Signal to the actor that they have taken damage. 
	# They may have more take damage functionality to implement. 
	if health > 0: handle_attack.emit(attack, false)
	# Signal to the actor that they have died. 
	# They may have more take death functionality to implement. 
	else: handle_attack.emit(attack, true)


## In the case the actor has a variable "is_invulnerable" and it is true, 
## they will not take damage during this attack. 
func handle_invulnerability(attack: Hitbox): 
	if "is_invulnerable" in actor: 
		if not actor.is_invulnerable: 
			PlayerStats.health -= 1
			health -= attack.damage
	else: 
		health -= attack.damage
		PlayerStats.health -= 1
	

			
