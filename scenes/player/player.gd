extends CharacterBody2D
class_name Player

## Global resources
const UNITS = preload("res://utilitites/resources/units.tres")

const SPEED = 160.0
const acceleration: float = 1200.0
const friction: float = 1300.0

## State Machines
@onready var state_machine: Node = $StateMachine
@onready var attack_state_machine: Node = $AttackStateMachine

## General
@onready var arm_pivot: Marker2D = $General/ArmPivot
@onready var sprite: Sprite2D = $General/Sprite
@onready var bullet_marker: Marker2D = $General/ArmPivot/BulletMarker
@onready var animator: AnimationPlayer = $General/Animator
@onready var arm_sprite: Sprite2D = $General/ArmPivot/ArmSprite
@onready var animator_2: AnimationPlayer = $General/Animator2

## UI 
@onready var respawn_button = $UI/RespawnButton
@onready var heart_container = $UI/HeartContainer
@onready var health_component = $Components/HealthComponent

signal damaged

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	respawn_button.visible = false
	state_machine.init(self)
	attack_state_machine.init(self)	
	
	health_component.init(PlayerStats.health, PlayerStats.max_health) 
	

func _enter_tree():
	UNITS.player = self
	pass

func _on_health_component_handle_attack(attack: Hitbox, has_died: bool = false) -> void:
	
	# Invulnernable state. 
	if is_invulnerable: return
	
	#heart_container.deplete_heart()	
	if has_died: 
		state_machine.force_transition("death", attack)
	else: 
		state_machine.force_transition("damaged", attack)

@onready var invulnerable_timer: Timer = $General/InvulnerableTimer
var is_invulnerable: bool = false
func enter_invulnerable_state():
	is_invulnerable = true
	invulnerable_timer.start() 

func _on_invulnerable_timer_timeout() -> void:
	is_invulnerable = false


## Fire particles in the direction of the air bullet. 
func _on_aim_fired_weapon(knockback_data) -> void:
	state_machine.force_transition("knockback", knockback_data)
	var size 
	if knockback_data["is charged attack"]:
		size = 19
	else: 
		size = 10
	arm_pivot.fire_particles(size)


func die(): 
	state_machine.disabled = true 
	attack_state_machine.disabled = true 
	respawn_button.visible = true
	Events.player_died.emit()
	
func custom_deferred(func_name: StringName):
	call_deferred(func_name) 

func _on_respawn_button_pressed():
	Events.start_level.emit() 
	
###########################################
## State Machine Acessible Code 
###########################################

func handle_movement(delta): 
	# Handle player movement. 
	var direction := Input.get_axis("left", "right")
	# Move in the given direction when move is pressed. 
	if direction: velocity.x = move_toward(velocity.x, direction * SPEED, delta * acceleration)
	# Not moving. Graudally lower velocity to 0.
	else: velocity.x = move_toward(velocity.x, 0, delta * friction)

func handle_gravity(delta):
	if not is_on_floor(): velocity.y += gravity * delta
	
func heal(): 
	if PlayerStats.can_heal():
		PlayerStats.dust_particles -= PlayerStats.heal_cost
		health_component.heal()
	
"""
	Handle Jump
	
	Requirements: 
		- Call handle_jump() in the states physics_process. 
		- Check if can_jump before jumping. 
"""
@onready var coyote_timer: Timer = $General/CoyoteTimer
var coyote_time: float = 0.2
var can_jump = true


## Handles when the player can jump. 
## If the player is on the floor, they can jump. 
## If they walk off a platform, they have a coyote timer to jump.
func handle_jump(): 
	# Handle coyote timer.
	if is_on_floor() and not can_jump: 
		can_jump = true 
	# The player has just left the floor. 
	# It can still jump for now. Start the coyote timer. 
	# When it stops, the player can't jump. 
	elif can_jump and coyote_timer.is_stopped():
		coyote_timer.start(coyote_time)
	
	# Don't let the player fall during coyote time. 
	if not coyote_timer.is_stopped(): 
		velocity.y = 0 

func _on_coyote_timer_timeout() -> void:
	can_jump = false




