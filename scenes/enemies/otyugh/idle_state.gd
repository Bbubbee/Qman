extends State

var direction: int = 1


func enter(_enter_params = null):
	actor.animator.play("idle")

func physics_process(delta):
	actor.handle_gravity(delta) 
	
	# Turn around when the otyugh touches a wall. 
	if actor.is_on_wall():
		direction *= -1
	
	actor.velocity_component.move(delta, direction)
	actor.move_and_slide()
	
	# Detect Player. 
	if actor.can_detect_player: transition.emit(self, "follow")
	
	
	
	
