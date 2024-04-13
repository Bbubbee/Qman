extends State


func enter(_enter_params = null): 	
	actor.animator.play("run")


func physics_process(delta: float): 	
	actor.handle_movement(delta)
	actor.handle_gravity(delta)
	actor.move_and_slide()
	actor.handle_jump() 
	
	# The player has stopped moving, go back to idle. 
	if actor.velocity.x == 0: transition.emit(self, "idle")
	


func on_input(event: InputEvent): 
	if event.is_action_pressed("jump") and actor.can_jump:
		transition.emit(self, "jump") 
	
	if event.is_action_pressed("heal") and PlayerStats.can_heal():
		transition.emit(self, "heal")

