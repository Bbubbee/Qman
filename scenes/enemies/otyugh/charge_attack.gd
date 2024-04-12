extends State

var direction
var original_speed 
var original_acceleration

var charge_speed: float = 550
var charge_acceleration: float = 200


func enter(_enter_params = null):
	# Store the original move data to remove it after charging. 
	original_speed = actor.velocity_component.speed
	original_acceleration = actor.velocity_component.acceleration
	
	var dir = Globals.get_direction_to_target(actor,  actor.UNITS.player)
	if dir.x > 0: direction = 1
	else: direction = -1
	
	actor.velocity_component.speed = charge_speed
	actor.velocity_component.acceleration = charge_acceleration


func physics_process(delta: float) -> void:
	actor.velocity_component.move(delta, direction)
	actor.move_and_slide()
	
	if actor.is_on_wall():
		transition.emit(self, "idle")

func exit():
	actor.velocity_component.speed = original_speed
	actor.velocity_component.acceleration = original_acceleration
	
	
