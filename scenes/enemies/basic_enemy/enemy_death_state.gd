extends State


func enter():
	print("im dead")
	actor.animator.play("death")
	

func _on_animator_animation_finished(anim_name: StringName) -> void:	
	if anim_name == "death": 
		actor.queue_free()
		
