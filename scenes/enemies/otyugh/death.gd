extends State

@onready var animation_timer = $AnimationTimer

func enter(_enter_params = null):
	actor.animator.play("death")
	animation_timer.start()
	

func die(): 
	Events.explode_dust_particles.emit(actor.position, 70)
	actor.queue_free()


func _on_animation_timer_timeout():
	call_deferred("die")
