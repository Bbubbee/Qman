extends State


@export var tentacle_attack_range: float 


func enter(_enter_params = null):
	actor.animator.play("idle")
	
func physics_process(delta):
	actor.handle_gravity(delta) 
	
	# Follow player. 
	actor.velocity_component.move_towards(delta, actor.UNITS.player.global_position)
	
	# Check within range of player for an attack. 
	var distance = Globals.get_distance_between_two_targets(actor, actor.UNITS.player)
	if distance < tentacle_attack_range: 
		transition.emit(self, "spitattack")
	
	actor.move_and_slide() 
	

