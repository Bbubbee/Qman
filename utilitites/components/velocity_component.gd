extends Node2D


@export var actor: Node2D
@export var speed: float = 100
@export var acceleration: float = 50


func move_towards(_target: Vector2): 
	pass


## Moves in the left or right direction.
func move(delta: float, direction: int): 
	if not actor: return
	
	actor.velocity.x = move_toward(actor.velocity.x, speed * direction, delta * acceleration)

