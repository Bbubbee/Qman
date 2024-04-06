extends Node2D

@onready var animator = $Animator

func _on_health_component_handle_attack(attack, has_died):
	animator.play("hit")
	if has_died: 
		call_deferred("destroy", attack)

func destroy(attack):
	Events.spawn_particles.emit(self.global_position, 14, attack.direction)		
	queue_free()
