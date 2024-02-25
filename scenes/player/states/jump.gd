extends State

@export var jump_height: float = 200 

func enter(_enter_params = null): 
	await get_tree().create_timer(5.0).timeout 
	print("jumping on dat dick")
	


func physics_process(_delta: float) -> void:
	actor.velocity.y = -jump_height
	
	#if actor.attack_incoming: 
		#transition.emit(self, "damaged")
	
	transition.emit(self, "move") 
	
