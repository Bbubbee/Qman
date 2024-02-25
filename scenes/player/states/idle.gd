extends State


func enter(_enter_params = null): 
	actor.velocity.x = 0


func on_input(event: InputEvent):	
	var moving = Input.get_axis('left', 'right')
	if moving: transition.emit(self, "move") 
	
	# Handle jump.
	if event.is_action_pressed("jump") and actor.is_on_floor():
		transition.emit(self, "jump") 
	

func physics_process(delta: float) -> void:
	if not actor.is_on_floor():
		actor.velocity.y += actor.gravity * delta
	actor.move_and_slide()
	
	#if actor.attack_incoming: 
		#transition.emit(self, "damaged")
