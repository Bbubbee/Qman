extends State


func enter(_enter_params = null):
	actor.animator.play("death")
	call_deferred("disable") 
	

func trigger_death(): 
	call_deferred("die") 

func die(): 
	print('calling die')
	actor.animator.pause()
	Events.explode_dust_particles.emit(actor.global_position, 25)
	actor.sprite.visible = false
	actor.respawn_button.visible = true
	

func disable(): 
	actor.state_machine.disabled = true 
	actor.attack_state_machine.disabled = true 
	#actor.respawn_button.visible = true
	Events.player_died.emit()
