extends State


func enter(_enter_params = null):
	actor.animator.play("death")
	
	Events.spawn_particles.emit(actor.position, 10)
	
	# Spawn a bunch of dust particles
	#for x in randi_range(3, 15):
		#var dust = actor.DUST_PARTICLE.instantiate()
		#
		## Make the dust spawn in a random spot on a cone. 
		#dust.position = actor.position + Vector2(randf_range(-10, 10), randf_range(-10, 0))
		#
		#var root = get_tree().get_root()
		#root.add_child(dust)


func _on_animator_animation_finished(anim_name: StringName) -> void:	
	if anim_name == "death": 
		actor.queue_free()
		
		
