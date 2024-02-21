extends State

# A cool down because I want to transition before the 
# animation ends. 
var cooldown: float = 0.25
var timer: float


func enter(): 
	actor.velocity.x = 0
	#actor.animator.play("damaged") 
	actor.attack_incoming = null
	
	timer = cooldown


func process(delta: float) -> void:
	# Transition to wander after a cooldown. 
	timer -= delta 
	if timer < 0: 
		transition.emit(self, "wander")
	

		
