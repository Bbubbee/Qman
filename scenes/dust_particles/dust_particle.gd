extends RigidBody2D



func _ready() -> void:
	var x = randf_range(100, 200)
	var y = randf_range(-100, -200)
	apply_impulse(Vector2(x, y), self.position)
#
#const SPEED = 400.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#func _ready() -> void:
	#velocity.y = JUMP_VELOCITY
	#velocity.x = SPEED
	#
#
#
#func init(direction: Vector2): 
	#pass
	#
#
#
#func _physics_process(delta: float) -> void:
	##velocity.x = move_toward(velocity.x, 0, 1)
	#
	## Move the x velocity to zero by gravity (or some value) * delta. 
	#if velocity.x > 0:
		#velocity.x = maxf(velocity.x - gravity * delta, 0)
	#elif velocity.x < 0: 
		#velocity.x = minf(velocity.x + gravity * delta, 0)
	#else: 
		#velocity.x = 0
	#
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta


	#move_and_slide()
