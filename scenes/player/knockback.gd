extends State


var direction 
var force = 100

var x
var y
@onready var knockback_timer: Timer = $KnockbackTimer


func enter(_enter_params = null): 
	knockback_timer.start()
	direction = _enter_params
	

func physics_process(delta: float) -> void: 		
	x = -direction.x * force
	y = -direction.y * force
	
	actor.velocity = Vector2(x, y)
	
	# Handle gravity.
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	
	actor.move_and_slide()


func _on_knockback_timer_timeout() -> void:
		transition.emit(self, "move")
