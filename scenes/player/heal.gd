extends State

@onready var heal_timer = $HealTimer

func enter(_enter_params = null):
	heal_timer.start()

func physics_process(delta):
	# Come to a stop. 
	actor.velocity.x = move_toward(actor.velocity.x, 0, delta * actor.friction)
	actor.move_and_slide()

func on_input(_event: InputEvent): 
	if _event.is_action_released("heal"):
		transition.emit(self, "idle")
		heal_timer.stop()

func _on_heal_timer_timeout():
	actor.heal()
	transition.emit(self, "idle")
	
