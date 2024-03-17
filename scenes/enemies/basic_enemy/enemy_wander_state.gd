extends State

@export var sight_range: float = 50.0
var wander_time: float 
var move_direction: int

func enter(_enter_params = null): 
	if not actor.animator.is_playing():
		actor.animator.play("idle")
	
	randomise_wander()
 
func process(delta: float) -> void:
	# Wanders around. 
	if wander_time > 0: wander_time -= delta
	else: randomise_wander()

func physics_process(delta: float) -> void:
	# Handle gravity. 
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	actor.move_and_slide()
	
	# Wander. 
	actor.velocity.x = move_direction * actor.SPEED
	
	var player = actor.UNITS.player
	
	# Follow the player if close enough. 
	if player: 
		var direction = player.global_position - actor.global_position
		if direction.length() < sight_range:  
			transition.emit(self, "follow") 

func _on_animator_animation_finished(_anim_name: StringName) -> void:
	actor.animator.play("idle")

## Sets the direction the enemy will wander and the time they will wander
## in that direction. 
func randomise_wander(): 
	move_direction = randi_range(0, 1) 
	actor.facing_right = true
	if move_direction == 0: 
		move_direction = -1
		actor.facing_right = false
	wander_time = randf_range(1, 3)
	
