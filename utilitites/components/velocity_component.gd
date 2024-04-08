extends Node2D
class_name VelocityComponent 


@export var actor: Node2D
@export var speed: float = 100
@export var acceleration: float = 500
@export var friction: float = 500

## Move towards a target on the x axis. 
##   @param: target - The global position of the target. 
func move_towards(delta, target: Vector2): 
	var direction = actor.global_position - target
	
	# Move right. 
	if direction.x > 0: move(delta, -1) 
	# Move left. 
	else: move(delta, 1) 


## Moves in the left or right direction.
func move(delta: float, direction: int): 
	if not actor: return

	actor.velocity.x = move_toward(actor.velocity.x, speed * direction, acceleration*delta)


# Slows to a stop. 
func stop(delta: float): 
	actor.velocity.x = move_toward(actor.velocity.x, 0, friction*delta)
