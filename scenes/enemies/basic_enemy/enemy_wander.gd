extends State


func enter(): 
	if not actor.animator.is_playing():
		actor.animator.play("idle")

func physics_process(delta: float) -> void:
	# Basic movement in one direction. 
	if not actor.is_on_floor():
		actor.velocity.y += actor.gravity * delta
	actor.velocity.x = -1 * actor.SPEED
	actor.move_and_slide()
	#actor.sprite_2d.flip_h = actor.velocity.x > 0
	
	if actor.attack_incoming: 
		transition.emit(self, "damaged")
	
	if actor.has_died: 
		transition.emit(self, "death")

func _on_animator_animation_finished(anim_name: StringName) -> void:
	actor.animator.play("idle")
