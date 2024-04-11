extends State


@export var spit_attack_range: float = 100 


func enter(_enter_params = null):
	actor.animator.play("idle")
	
func physics_process(delta):
	actor.handle_gravity(delta) 
	
	# Follow player. 
	actor.velocity_component.move_towards(delta, actor.UNITS.player.global_position)
	
	attack_decider()
	actor.move_and_slide() 
	
@onready var spit_cooldown: Timer = $Cooldowns/SpitCooldown
func attack_decider():
	# Spit attack. 
	var distance = Globals.get_distance_between_two_targets(actor, actor.UNITS.player)
	if distance < spit_attack_range and spit_cooldown.is_stopped(): 
		spit_cooldown.start()
		transition.emit(self, "spitattack")
	
	# Spin attack. 
	
	
	

