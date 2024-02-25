extends State

var player: CharacterBody2D

func enter(_enter_params = null):
	var level = get_tree().current_scene
	player = level.find_child("Player")
	

func physics_process(delta: float):
	# Handle gravity. 
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	actor.move_and_slide()
	
	if not player: 
		transition.emit(self, "wander")
	
	# Move towards the player. 
	var direction = player.global_position - actor.global_position 

	# Stop moving 25 pixels away from the player
	if direction.x > 0: 
		actor.velocity.x = 1 * actor.SPEED 
	else: 
		actor.velocity.x = -1 * actor.SPEED  

	# Once the player is too far away, go to the idle state. 
	if direction.length() > 100:
		transition.emit(self, "wander") 
	
	if actor.attack_incoming: 
		transition.emit(self, "damaged")
