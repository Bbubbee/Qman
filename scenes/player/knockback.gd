extends State


var direction 
@export var force: float = 100

var x
var y
@onready var knockback_timer: Timer = $KnockbackTimer


func enter(_enter_params = null): 
	knockback_timer.start()
	direction = _enter_params
	
	if not actor.is_on_floor(): 
		actor.animator.play("jump")
	else: 
		actor.animator.play("move")
	

func physics_process(delta: float) -> void: 		
	x = -direction.x * force
	y = -direction.y * force
	
	# Only knockback if player is not on the floor 
	# and is shooting steeply into the ground.
	if not actor.is_on_floor() and y < -40:
		actor.velocity = Vector2(x, y)
	
	# Handle gravity.
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	
	actor.move_and_slide()


func _on_knockback_timer_timeout() -> void:
	transition.emit(self, "move")
		
