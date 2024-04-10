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
	dust_ball.init(Vector2.RIGHT, actor.global_position) 
	get_tree().current_scene.add_child(dust_ball)
	
	await get_tree().create_timer(0.5).timeout
	transition.emit(self, "idle") 
	
	
	

	
