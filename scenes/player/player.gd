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

signal damaged

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	#UNITS.player = self
	respawn_button.visible = false
	state_machine.init(self)
	attack_state_machine.init(self)	

func _enter_tree():
	UNITS.player = self

func _on_health_component_handle_attack(attack: Hitbox, has_died: bool = false) -> void:
	heart_container.deplete_heart()		
	
	if has_died: 
		state_machine.force_transition("death", attack)
	else: 
		state_machine.force_transition("damaged", attack)


## Fire particles in the direction of the air bullet. 
func _on_aim_fired_weapon(direction) -> void:
	state_machine.force_transition("knockback", direction)
	arm_pivot.fire_particles()


func die(): 
	UNITS.player = null
	state_machine.disabled = true 
	attack_state_machine.disabled = true 
	respawn_button.visible = true
	Events.player_died.emit()
	

func _on_respawn_button_pressed():
	print("button pressed")
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
	
"""
	Handle Jump
"""
@onready var coyote_timer: Timer = $General/CoyoteTimer
var coyote_time: float = 0.25
var can_jump = false

func handle_jump(): 
	# Handle coyote timer.
	if is_on_floor() and not can_jump: 
		can_jump = true 
	elif can_jump and coyote_timer.is_stopped():
		coyote_timer.start(coyote_time)
	
	# Don't let the player fall during coyote time. 
	if coyote_timer.time_left > 0: 
		velocity.y = 0 

func _on_coyote_timer_timeout() -> void:
	can_jump = false
