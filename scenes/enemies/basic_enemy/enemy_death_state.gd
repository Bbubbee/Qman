extends State

var play_once: bool = true
var direction


func enter(_enter_params = null):
	actor.animator.play("death")
	direction = _enter_params.direction


func process(_delta: float) -> void:
	if play_once: 
		play_once = false 
		Events.spawn_particles.emit(actor.position, 10, direction)		
		

func _on_animator_animation_finished(anim_name: StringName) -> void:	
	if anim_name == "death": 
		actor.queue_free()
		
		
		
