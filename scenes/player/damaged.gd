extends State


func enter():
	actor.animator.play("hurt")
	actor.attack_incoming = null
	

func process(delta: float) -> void:
	if not actor.animator.is_playing(): 
		transition.emit(self, "move")  
