extends State

var player: CharacterBody2D
@export var attack_range: float = 20.0
@onready var attack_timer: Timer = $AttackTimer


func enter(_enter_params = null):
	attack_timer.start()
	var level = get_tree().current_scene
	player = level.find_child("Player")
	

func physics_process(delta: float):
	# Handle gravity. 
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	actor.move_and_slide()
	
	# Move towards the player. 
	var direction = player.global_position - actor.global_position 
	
	# Make sprite face player.
	if player.global_position > actor.global_position:
		actor.sprite_2d.flip_h = true 
	else:
		actor.sprite_2d.flip_h = false
		

	# Stop moving x pixels away from the player.
	if direction.length() > attack_range: 
		if direction.x > 0:
			actor.velocity.x = 1 * actor.SPEED
			actor.facing_right = true
		else: 
			actor.velocity.x = -1 * actor.SPEED  
			actor.facing_right = false
			
	else: 
		actor.velocity.x = 0
		if attack_timer.is_stopped():
			transition.emit(self, "attack")

	# Once the player is too far away, go to the idle state. 
	if direction.length() > 100:
		transition.emit(self, "wander") 


#func exit():
	#attack_timer
	

