extends State

const DUST_BALL = preload("res://scenes/projectiles/othyugh_dust_ball.tscn")

func enter(_enter_params = null):
	# Stop moving. 
	actor.animator.play("spit_attack")
	

func physics_process(delta):
	actor.velocity_component.stop(delta)
	actor.handle_gravity(delta) 	

	actor.move_and_slide()

func attack(): 
	var dust_ball = DUST_BALL.instantiate() 
	# Get direction of player. 
	var dir = Globals.get_direction_to_target(actor, actor.UNITS.player)

	
	dust_ball.init(dir, actor.global_position) 
	get_tree().current_scene.add_child(dust_ball)
	
	await get_tree().create_timer(0.5).timeout
	transition.emit(self, "idle") 
	
	
	

	
