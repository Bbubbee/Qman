extends State

var wander_time: float 
var move_direction: int
var player: Player

func enter(_enter_params = null): 
	if not actor.animator.is_playing():
		actor.animator.play("idle")
	
	# Get player. 
	var level = get_tree().current_scene
	player = level.find_child("Player")
	
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
	
	
	# Follow the player if close enough. 
	if player: 
		var direction = player.global_position - actor.global_position
		if direction.length() < 75:  
			transition.emit(self, "follow") 

func _on_animator_animation_finished(_anim_name: StringName) -> void:
	actor.animator.play("idle")

## Sets the direction the enemy will wander and the time they will wander
## in that direction. 
func randomise_wander(): 
	move_direction = randi_range(0, 1) 
	if move_direction == 0: move_direction = -1
	wander_time = randf_range(1, 3)
	


#func physics_update(delta):
	#if enemy: enemy.velocity.x = move_direction * move_speed
#
	## Looks for the player. Will follow once close enough. 
	#var direction = player.global_position - enemy.global_position
	#if direction.length() < 250:  
		#transitioned.emit(self, "follow") 

