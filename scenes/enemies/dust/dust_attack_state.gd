extends EnemyAttackState

const DUST_BALL = preload("res://scenes/projectiles/dust_ball.tscn")
@onready var attack_marker: Marker2D = $"../../AttackMarker"


func enter(_enter_params = null):
	attack_timer = attack_duration 
	
	# NOTE: May have to call this one in process instead of in enter. 
	
	# Get player.
	var level = get_tree().current_scene
	var player = level.find_child("Player")
	
	# Prepare the attack.
	var dust_ball = DUST_BALL.instantiate() 	
	var direction = (player.global_position - actor.global_position).normalized()
	dust_ball.init(direction, attack_marker.global_position)
	
	# Add dust ball to root. 
	var root = get_tree().get_root()
	root.add_child(dust_ball)


func physics_process(delta: float) -> void:
	# Handle gravity. 
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	actor.move_and_slide()
		


"""
	TODO: 
		- Sneeze ranged attack.
"""
