extends State


func enter(_enter_params = null):
	actor.animator.play("death")
	

func _on_animator_animation_finished(anim_name: StringName) -> void:	
	if anim_name == "death": 
		actor.queue_free()
		
