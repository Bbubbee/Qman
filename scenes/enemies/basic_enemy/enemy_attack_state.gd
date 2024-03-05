extends State
class_name EnemyAttackState

@export var attack_duration: float = 1.5 
var attack_timer: float = attack_duration 

func enter(_enter_params = null):
	print("enemy attack state")
	attack_timer = attack_duration
	actor.velocity = Vector2.ZERO

func process(delta: float) -> void:
	attack_timer -= delta 
	if attack_timer < 0: 
		transition.emit(self, "wander")
	


