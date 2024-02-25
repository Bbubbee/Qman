extends State


# Play this state only for a cooldown amount of time. 
var cooldown: float = 0.15
var cooldown_timer: float


func enter(_enter_params = null):
	var attack = _enter_params
	cooldown_timer = cooldown
	actor.animator.play("hurt")
	actor.velocity = attack.direction * attack.knockback


func physics_process(delta: float) -> void:
	actor.move_and_slide()
	cooldown_timer -= delta
	if cooldown_timer < 0:
		transition.emit(self, "move")  
