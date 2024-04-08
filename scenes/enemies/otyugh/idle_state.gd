extends State

var direction: int = 1


func physics_process(delta):
	actor.handle_gravity(delta) 
	
	# Turn around when the otyugh touches a wall. 
	if actor.is_on_wall():
		direction *= -1
		actor.sprite.flip_h = direction
	
	# Face the direction the otyugh is moving in. 
	if direction > 0: 
		actor.sprite.flip_h = false
	else: 
		actor.sprite.flip_h = true
	
	# Move in a given direction. 
	actor.velocity_component.move(delta, direction)
	actor.move_and_slide()
	
	# Detect Player. 
	if actor.can_detect_player: transition.emit(self, "follow")
	
	
	
	
