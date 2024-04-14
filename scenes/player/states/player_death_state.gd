extends State


func enter(_enter_params = null):
	actor.animator_2.play("hurt")
	actor.animator.play("death")
	call_deferred("disable") 
	
## Called for the explosion animation.
func trigger_death(): 
	call_deferred("die") 

func die(): 
	Globals.play_hurt_sfx(actor.global_position)
	Globals.play_explosion_sfx(actor.global_position)
	
	actor.animator.pause()
	Events.explode_dust_particles.emit(actor.global_position, 25)
	Events.screen_shake.emit()	
	actor.sprite.visible = false
	actor.respawn_button.visible = true
	

func disable(): 
	actor.is_dead = true
	actor.disable()
	actor.state_machine.disabled = true 
	actor.attack_state_machine.disabled = true 
	#actor.respawn_button.visible = true
	Events.player_died.emit()
