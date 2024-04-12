extends State




func enter(_enter_params = null):
	actor.animator.play("idle")
	
func physics_process(delta):
	actor.handle_gravity(delta) 
	
	# Follow player. 
	actor.velocity_component.move_towards(delta, actor.UNITS.player.global_position)
	
	attack_decider()
	actor.move_and_slide() 
	

func attack_decider():
	var distance = Globals.get_distance_between_two_targets(actor, actor.UNITS.player)
	
	charge_attack(distance)	
	spit_attack(distance)
	
@onready var charge_cooldown: Timer = $Cooldowns/ChargeCooldown

func charge_attack(distance): 
	if distance < 200 and charge_cooldown.is_stopped():
		charge_cooldown.start() 
		transition.emit(self, "chargeattack")
		
		
@export var spit_attack_range: float = 100 
@onready var spit_cooldown: Timer = $Cooldowns/SpitCooldown

func spit_attack(distance): 
	return
	if distance < spit_attack_range and spit_cooldown.is_stopped(): 
		spit_cooldown.start()
		transition.emit(self, "spitattack")
	
	

