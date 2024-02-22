extends State

# A cool down because I want to transition before the 
# animation ends. 
var cooldown: float = 0.25
var timer: float
var animator: AnimationPlayer


func enter(): 
	animator = actor.animator
	actor.velocity.x = 0
	animator.play("damaged") 
	actor.attack_incoming = null
	timer = cooldown


func process(delta: float) -> void:
	if actor.has_died: 
		transition.emit(self, "death")
		
	# Transition to wander after a cooldown. 
	timer -= delta 
	if timer < 0: 
		transition.emit(self, "wander")
	
	

		
