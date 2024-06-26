extends State


var direction: Vector2


func enter(_enter_params = null): 
	direction = _enter_params["direction"]
	
	var is_charged = _enter_params["is charged attack"]
	
	var x
	var y 
	
	
	if is_charged: 
		x = -direction.x * PlayerStats.charge_attack_knockback_force
		y = -direction.y * PlayerStats.charge_attack_knockback_force
	else: 
		x = -direction.x * PlayerStats.attack_knockback_force
		y = -direction.y * PlayerStats.attack_knockback_force
	
	# Only knockback if player is not on the floor 
	# and is shooting steeply into the ground.
	if not actor.is_on_floor() and y < -40:
		actor.velocity = Vector2(x, y)

func physics_process(delta: float) -> void: 		
	actor.handle_gravity(delta)
	actor.handle_movement(delta)
	actor.move_and_slide()
	actor.handle_jump()
	
	if actor.is_on_floor(): transition.emit(self, "move") 
	
	
func on_input(event: InputEvent): 
	if event.is_action_pressed("jump") and actor.can_jump:
		transition.emit(self, "jump") 
		
