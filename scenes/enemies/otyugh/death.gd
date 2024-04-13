extends State

@onready var animation_timer = $AnimationTimer

func enter(_enter_params = null):
	actor.animator.play("death")
	animation_timer.start()
	actor.hurt_hit_box.call_deferred("disable")	
	
	

func die(): 
	actor.died.emit()
	Events.screen_shake.emit()
	Events.explode_dust_particles.emit(actor.position, 70)
	actor.queue_free()


func _on_animation_timer_timeout():
	call_deferred("die")
