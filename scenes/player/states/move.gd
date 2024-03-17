extends State


var can_jump: bool = false 
var coyote_time = 0.2

@onready var coyote_timer = $CoyoteTimer

func enter(_enter_params = null): 	
	actor.animator.play("run")


func physics_process(delta: float): 	
	# Handle player movement. 
	var direction := Input.get_axis("left", "right")
	# Move in the given direction when move is pressed. 
	if direction: actor.velocity.x = move_toward(actor.velocity.x, direction * actor.SPEED, delta * actor.acceleration)
	# Not moving. Graudally lower velocity to 0.
	else: actor.velocity.x = move_toward(actor.velocity.x, 0, delta * actor.friction)
	
	# The player has stopped moving, go back to idle. 
	if actor.velocity.x == 0: 
		transition.emit(self, "idle")
	
	# Apply gravity.
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	
	handle_jump() 
	
	actor.move_and_slide()
	
	
	
func handle_jump(): 
	# Handle coyote timer.
	if actor.is_on_floor() and not can_jump: 
		can_jump = true 
	elif can_jump and coyote_timer.is_stopped():
		coyote_timer.start(coyote_time)
	
	# Don't let the player fall during coyote time. 
	if coyote_timer.time_left > 0: 
		actor.velocity.y = 0 

func on_input(event: InputEvent): 
	if event.is_action_pressed("jump") and can_jump:
		can_jump = false
		transition.emit(self, "jump") 


## Another animation has finished. Play move animation now. 
func _on_animator_animation_finished(_anim_name: StringName) -> void:
	pass
	#if anim_name == "damaged":
		#actor.animator.play('run')


func _on_coyote_timer_timeout():
	can_jump = false
