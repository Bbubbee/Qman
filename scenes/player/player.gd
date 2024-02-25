extends CharacterBody2D
class_name Player


const SPEED = 200.0

@onready var arm_pivot: Marker2D = $ArmPivot
@onready var state_machine: Node = $StateMachine
@onready var attack_state_machine: Node = $AttackStateMachine
@onready var sprite: Sprite2D = $Sprite
@onready var bullet_marker: Marker2D = $ArmPivot/BulletMarker
@onready var animator: AnimationPlayer = $Animator

signal damaged

#var attack_incoming: Hitbox
	# Used to determine when to go to the damaged state. 
	# Made true in health component.

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	state_machine.init(self)
	attack_state_machine.init(self)
	

func _on_health_component_handle_attack(attack: Hitbox, _has_died: bool = false) -> void:
		state_machine.force_transition("damaged", attack)
