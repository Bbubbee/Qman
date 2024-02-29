extends State



func enter(_enter_params = null): 
	# Only play the move animation if other animations are done.
	if not actor.animator.is_playing():
		actor.animator.play("idle")


func physics_process(delta: float): 	
	# Handle player movement. 
	var direction := Input.get_axis("left", "right")
	# Move in the given direction when move is pressed. 
	if direction: actor.velocity.x = direction * actor.SPEED
	# Not moving. Graudally lower velocity to 0.
	else: actor.velocity.x = move_toward(actor.velocity.x, 0, actor.SPEED)
	actor.move_and_slide()
	
	
	# The player has stopped moving, go back to idle. 
	if actor.velocity.x == 0: 
		transition.emit(self, "idle")
	
	# Apply gravity.
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	
	# Handle damaged.
	#if actor.attack_incoming: 
		#transition.emit(self, "damaged")
	

func on_input(event: InputEvent): 
	if event.is_action_pressed("jump") and actor.is_on_floor():
		transition.emit(self, "jump") 


## Another animation has finished. Play move animation now. 
func _on_animator_animation_finished(_anim_name: StringName) -> void:
	actor.animator.play('idle')
