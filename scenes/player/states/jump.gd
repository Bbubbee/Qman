extends State

@export var jump_height: float = 200 	


func enter(_enter_params = null):
	# Restart the coyote timer. 
	actor.can_jump = false
	actor.coyote_timer.stop()

	actor.animator.play("jump")
	actor.velocity.y = -jump_height
	

func physics_process(delta: float) -> void:	
	actor.handle_movement(delta)
	actor.handle_gravity(delta) 
	actor.move_and_slide()
	
	if actor.is_on_floor(): transition.emit(self, "move") 
	
	
	
	
