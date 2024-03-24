extends EnemyAttackState

@onready var windup_timer: Timer = $WindupTimer
@export var jump_force: Vector2 = Vector2(100, 75)
var has_jumped: bool = false

func enter(_enter_params = null):
	has_jumped = false
	windup_timer.start()
	attack_timer = 0.8
	actor.velocity = Vector2.ZERO
	
# NOTE: Process will eventually transition back to the wander state so we override it here. 
func process(_delta: float) -> void:
	pass
	
func physics_process(delta: float) -> void:
	# Handle gravity. 
	actor.handle_gravity(delta) 
	actor.move_and_slide()
	
	# Once the baby has jumped, go back to idle. 
	if actor.is_on_floor() and has_jumped: 
		has_jumped = false
		transition.emit(self, "wander") 
	

func _on_windup_timer_timeout() -> void:
	# Get the direction of the player. 
	var player = actor.UNITS.player
	
	if not player: transition.emit(self, "wander")
	
	var direction = player.global_position - actor.global_position
	if direction.x > 0: 
		actor.facing_right = true 
	else: 
		actor.facing_right = false 
		
	if actor.facing_right: actor.velocity.x = jump_force.x
	else: actor.velocity.x = -jump_force.x
	actor.velocity.y = -jump_force.y
	
	has_jumped = true
