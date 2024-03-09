extends State



func enter(_enter_params = null): 
	# Only play the move animation if other animations are done.
	#
	#if actor.animator.current_animation == "idle":
		#print("current animation is idle")
		#actor.animator.play("run")
	#else: 
		#print("current animation is something else")		
		#actor.animator.queue("run")
	#actor.animator.play("run")
	
	actor.animator.play("run")


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
	

func on_input(event: InputEvent): 
	if event.is_action_pressed("jump") and actor.is_on_floor():
		transition.emit(self, "jump") 


## Another animation has finished. Play move animation now. 
func _on_animator_animation_finished(anim_name: StringName) -> void:
	pass
	#if anim_name == "damaged":
		#actor.animator.play('run')
