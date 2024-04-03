extends State

const GUST = preload('res://scenes/player/actions/gust.tscn')
signal fired_weapon(knockback_data: Dictionary)
var can_shoot: bool = true
@onready var attack_timer: Timer = $AttackTimer

@export var suck: Node2D


func physics_process(_delta: float):
	var mouse_pos = actor.get_global_mouse_position()
	mouse_pos.x = floor(mouse_pos.x)
	mouse_pos.y = floor(mouse_pos.y)
	
	var pos = actor.global_position
	
	# Make the arm aim at the mouse. 
	actor.arm_pivot.look_at(mouse_pos)
	
	# Flip the sprite to face the correct direction.
	if mouse_pos.x+10 > pos.x:
		actor.sprite.flip_h = false
		actor.arm_sprite.flip_h = false
		actor.arm_pivot.position.x = -1
	else: 
		actor.sprite.flip_h = true
		actor.arm_sprite.flip_h = true
		actor.arm_pivot.position.x = 1

	handle_suck()
	handle_charged_attack()

func handle_suck(): 
	if Input.is_action_pressed('suck'):
		if is_charging_attack:
			is_charging_attack = false 
			
		var direction = (actor.get_global_mouse_position() - actor.bullet_marker.global_position)
		
		suck.suck(direction)
	

func on_input(event: InputEvent) -> void:
		
	if event.is_action_pressed('spit'):
		
		# Handle charge attack. 
		charge_attack_timer.start(charge_attack_length)
		is_charging_attack = true
		
		# Handle regular attack. 
		spit_attack(PlayerStats.attack_dmg)
	

func _on_attack_timer_timeout() -> void:
	can_shoot = true

"""
	Handle charge attack. 
"""
@onready var charge_attack_timer: Timer = $ChargeAttackTimer
var charge_attack_length: float = 1
var is_charging_attack: bool = false
func handle_charged_attack(): 
	if Input.is_action_just_released('spit'):	
		# A charge attack can be cancelled if right mb is pressed. 	
		if not is_charging_attack: 
			return
			
		is_charging_attack = false 
		
		# If charge attack timer is done, do charge attack.
		# Else don't do anything
		if charge_attack_timer.is_stopped() and PlayerStats.can_charge_attack():
			spit_attack(PlayerStats.charge_attack_dmg, true)
			PlayerStats.dust_particles -= 40
		else: 
			spit_attack(PlayerStats.attack_dmg, false)

		charge_attack_timer.stop()

func spit_attack(dmg: float, is_charged: bool = false): 
	if not can_shoot: return 
	
	can_shoot = false
	attack_timer.start()
	
	var gust = GUST.instantiate()
	var root = get_tree().get_root()
	root.add_child(gust)
	
	var direction = (actor.get_global_mouse_position() - actor.global_position).normalized()
	gust.init(direction, actor.bullet_marker.global_position, dmg)
	
	var knockback_data = {"direction": direction, "is charged attack": is_charged}
	fired_weapon.emit(knockback_data)
	
