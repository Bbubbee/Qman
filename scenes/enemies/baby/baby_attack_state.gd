extends EnemyAttackState

@onready var windup_timer: Timer = $WindupTimer
@export var jump_force: Vector2 = Vector2(100, 75)
var has_jumped: bool = false

func enter(_enter_params = null):
	has_jumped = false
	windup_timer.start()
	attack_timer = 0.8
	actor.velocity = Vector2.ZERO
	
# Note: 
# Process will eventually transition back to the wanders state. 
func process(delta: float) -> void:
	pass
	
func physics_process(delta: float) -> void:
	# Handle gravity. 
	if not actor.is_on_floor(): actor.velocity.y += actor.gravity * delta
	

	
		
	actor.move_and_slide()
	
	# Once the baby has jumped, go back to idle. 
	if actor.is_on_floor() and has_jumped: 
		has_jumped = false
		transition.emit(self, "wander") 
	



func _on_windup_timer_timeout() -> void:
	
	actor.velocity.y = -jump_force.y
	
	if actor.facing_right: 
		actor.velocity.x = jump_force.x
	else: 
		actor.velocity.x = -jump_force.x
	
	has_jumped = true
	
	#transition.emit(self, 'follow')

	
	# Randomly generate jump force. 
	
	# Find the player and jump towards them. 
