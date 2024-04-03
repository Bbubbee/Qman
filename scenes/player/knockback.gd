extends State


var direction: Vector2
@export var force: float = 100


func enter(_enter_params = null): 
	direction = _enter_params["direction"]
	
	var is_charged = _enter_params["is charged attack"]
	
	var x
	var y 
	
	
	if is_charged: 
		x = -direction.x * force * 2
		y = -direction.y * force * 2
	else: 
		x = -direction.x * force * 1
		y = -direction.y * force * 1
	
	# Only knockback if player is not on the floor 
	# and is shooting steeply into the ground.
	if not actor.is_on_floor() and y < -40:
		actor.velocity = Vector2(x, y)

func physics_process(delta: float) -> void: 		
	actor.handle_gravity(delta)
	actor.handle_movement(delta)
	actor.handle_jump()
	actor.move_and_slide()
	
	if actor.is_on_floor(): transition.emit(self, "move") 
	
	
func on_input(event: InputEvent): 
	if event.is_action_pressed("jump") and actor.can_jump:
		transition.emit(self, "jump") 
		
