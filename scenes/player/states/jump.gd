extends State

@export var jump_height: float = 200 	


func enter(_enter_params = null):
	actor.animator.play("jump")
	actor.velocity.y = -jump_height
	

func physics_process(delta: float) -> void:
	# Apply gravity.
	if not actor.is_on_floor(): 
		actor.velocity.y += actor.gravity * delta
	
	# Handle player movement. 
	var direction := Input.get_axis("left", "right")
	# Move in the given direction when move is pressed. 
	if direction: actor.velocity.x = move_toward(actor.velocity.x, direction * actor.SPEED, delta * actor.acceleration)
	# Not moving. Graudally lower velocity to 0.
	else: actor.velocity.x = move_toward(actor.velocity.x, 0, actor.friction * delta)

	actor.move_and_slide()
	
	if actor.is_on_floor(): transition.emit(self, "move") 
	
	
	
	
