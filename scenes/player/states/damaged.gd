extends State


# Play this state only for a cooldown amount of time. 
var cooldown: float = 0.15
var cooldown_timer: float


func enter(_enter_params = null):
	var attack = _enter_params
	cooldown_timer = cooldown
	actor.animator_2.play("hurt")
	actor.velocity = attack.direction * (attack.knockback)
	actor.enter_invulnerable_state()


func physics_process(_delta: float) -> void:
	actor.handle_jump()
	actor.move_and_slide()	
	transition.emit(self, "move")  


# NOTE: May not want to be able to jump when getting damaged. 
# Might still ahve to handle_jump() though.
func on_input(event: InputEvent): 
	if event.is_action_pressed("jump") and actor.can_jump:
		transition.emit(self, "jump") 


