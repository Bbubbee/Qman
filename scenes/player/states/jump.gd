extends State

@export var jump_height: float = 200 


func physics_process(_delta: float) -> void:
	actor.velocity.y = -jump_height
	
	if actor.attack_incoming: 
		transition.emit(self, "damaged")
	
	transition.emit(self, "move") 
	
