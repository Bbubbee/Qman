extends State


func enter(_enter_params = null):
	print("In tentacle attack state")
	
	# Stop moving. 


func physics_process(delta):
	actor.velocity_component.stop(delta)
	actor.handle_gravity(delta) 	

	actor.move_and_slide()
	

	
