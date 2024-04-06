extends EnemyAttackState

const DUST_BALL = preload("res://scenes/projectiles/dust_ball.tscn")
@onready var attack_marker: Marker2D = $"../../AttackMarker"


func enter(_enter_params = null):
	actor.animator.play("attack")
	actor.velocity.x = 0
	actor.state_label.text = str("attack")
	
	
	attack_timer = attack_duration 
	
	# Face the player.
	var direction = (actor.UNITS.player.global_position - actor.global_position)
	if direction > Vector2.ZERO:
		actor.facing_right = true
	else: 
		actor.facing_right = false 


func process(_delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	# Handle gravity. 
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	actor.move_and_slide()

func fire_attack(): 
	# Get player.
	var level = get_tree().current_scene
	var player = level.find_child("Player")
	
	# Prepare the attack.
	var dust_ball = DUST_BALL.instantiate() 	
	var direction = (player.global_position - actor.global_position).normalized()
	
	# Flip the marker. 
	var attack_marker_pos = attack_marker.global_position
	if direction > Vector2.ZERO:
		attack_marker_pos.x += 20
		actor.facing_right = true
	else: 
		actor.facing_right = false 
	
	dust_ball.init(direction, attack_marker_pos)
	
	# Add dust ball to root. 
	var root = get_tree().get_root()
	root.add_child(dust_ball)
		

func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		transition.emit(self, "follow")
