extends CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	handle_gravity(delta)
	move_and_slide()


func handle_gravity(delta): 
	if not is_on_floor(): velocity.y += gravity * delta
