extends State

# A cool down because I want to transition before the animation ends. 
var cooldown: float = 0.2
var timer: float
var animator: AnimationPlayer


func enter(_enter_params = null): 
	animator = actor.animator
	#actor.velocity.x = 0
	animator.play("damaged") 
	timer = cooldown
	
	# Knockback. 
	#actor.velocity.x = 100
	actor.velocity = actor.attack_incoming.direction * 100
	
	actor.attack_incoming = null
	
	
	
	


func physics_process(delta: float) -> void:
	actor.move_and_slide()
	
	if actor.has_died: 
		transition.emit(self, "death")
		
	# Transition to wander after a cooldown. 
	timer -= delta 
	if timer < 0: 
		transition.emit(self, "wander")
	
	

		
