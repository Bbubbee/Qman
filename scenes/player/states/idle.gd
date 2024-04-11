extends State


func enter(_enter_params = null): 
	actor.animator.play("idle")
	actor.velocity.x = 0



func on_input(event: InputEvent):	
	var moving = Input.get_axis('left', 'right')
	if moving: transition.emit(self, "move") 
	
	# Handle jump.
	if event.is_action_pressed("jump") and actor.can_jump:
		transition.emit(self, "jump") 
	
	if event.is_action_pressed("heal"):
		actor.heal()
	

func physics_process(delta: float) -> void:
	actor.handle_gravity(delta) 
	actor.handle_movement(delta)
	actor.move_and_slide()
	actor.handle_jump() 
	
	#if actor.attack_incoming: 
		#transition.emit(self, "damaged")
