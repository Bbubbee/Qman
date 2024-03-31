extends Node2D

var triggered = false
@onready var ray = $PlayerDetector/Ray
@export var fall_speed: float = 100
@onready var animator = $Animator


func _physics_process(delta):
	if triggered: 
		position.y += fall_speed*delta
		

func _on_player_detector_area_entered(_area):
	animator.play("shake")
	ray.set_deferred("disabled", true)
	
	# Free after some time. 
	await get_tree().create_timer(5).timeout
	call_deferred("destroy")
	queue_free()


func fall(): 
	triggered = true
	

func _on_hitbox_area_entered(_area):
	call_deferred("destroy")
	queue_free()


func destroy(): 
	Events.spawn_particles.emit(self.global_position, 8, Vector2(0, -10))


func _on_animator_animation_finished(anim_name):
	if anim_name == "shake":
		fall()
