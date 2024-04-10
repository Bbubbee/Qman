extends State

@onready var spit_timer = $SpitTimer

func enter(_enter_params = null):
	actor.animator.play("spit_attack")
	

func physics_process(delta):
	actor.velocity_component.stop(delta)
	
	#if actor.velocity_component <= 0: 
		#transition.emit("spitattack")


func _on_spit_timer_timeout():
	transition.emit(self, "spitattack")
