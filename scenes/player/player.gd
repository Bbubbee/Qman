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
