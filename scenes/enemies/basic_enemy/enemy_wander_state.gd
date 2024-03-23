extends State

@export var sight_range: float = 50.0
var wander_time: float 
var move_direction: int

func enter(_enter_params = null): 
	if not actor.animator.is_playing():
		actor.animator.play("idle")
	
	# Randomly move left or right. 
	move_direction = randi_range(0, 1)
	if move_direction < 1: move_direction = -1 
	

func physics_process(delta: float) -> void:
	# Wander. 
	actor.velocity.x = move_direction * actor.SPEED 
	
	# Handle gravity. 
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta

	if not actor.floor_detector_ray.is_colliding(): 
		move_direction *= -1
	
	actor.move_and_slide()
	if actor.is_on_wall(): 
		move_direction *= -1
	
	if move_direction > 0: 
		actor.facing_right = true 
	else:
		actor.facing_right = false 
	
	handle_detect_player() 
	
	
func handle_detect_player(): 
	var player = actor.UNITS.player
	
	# Follow the player if close enough. 
	if player: 
		var direction = player.global_position - actor.global_position
		if direction.length() < sight_range:  
			transition.emit(self, "follow") 



func _on_animator_animation_finished(_anim_name: StringName) -> void:
	actor.animator.play("idle")

	
