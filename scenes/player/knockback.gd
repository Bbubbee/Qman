extends State


var direction: Vector2
@export var force: float = 100


func enter(_enter_params = null): 
	direction = _enter_params
	
	var x = -direction.x * force
	var y = -direction.y * force
	
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
		if actor.is_on_floor():
			transition.emit(self, "jump") 
		
