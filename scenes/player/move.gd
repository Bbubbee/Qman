extends State


func enter():
	print("Entering move state")


func physics_process(delta: float): 
	var direction := Input.get_axis("left", "right")
	
	# Move in the given direction when move is pressed. 
	if direction: actor.velocity.x = direction * actor.SPEED
	# Not moving. Graudally lower velocity to 0.
	else: actor.velocity.x = move_toward(actor.velocity.x, 0, actor.SPEED)
	
	# The player has stopped moving, go back to idle. 
	if actor.velocity.x == 0: 
		transition.emit(self, "idle")
		
	
