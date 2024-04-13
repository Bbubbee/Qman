extends State

# A cool down because I want to transition before the animation ends. 
var cooldown: float = 0.2
var timer: float
var animator: AnimationPlayer


func enter(_enter_params = null): 
	var attack = _enter_params
	animator = actor.animator
	#actor.velocity.x = 0
	#animator.play("damaged") 
	timer = cooldown
	
	
	# Knockback. 
	actor.velocity = attack.direction * attack.knockback
	


func physics_process(delta: float) -> void:
	actor.move_and_slide()
		
	# Transition to wander after a cooldown. 
	timer -= delta 
	if timer < 0: 
		transition.emit(self, "wander")
	
	

		
