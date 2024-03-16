extends CharacterBody2D
class_name Player


const SPEED = 160.0
const acceleration: float = 1200.0
const friction: float = 1300.0

@onready var arm_pivot: Marker2D = $ArmPivot
@onready var state_machine: Node = $StateMachine
@onready var attack_state_machine: Node = $AttackStateMachine
@onready var sprite: Sprite2D = $Sprite
@onready var bullet_marker: Marker2D = $ArmPivot/BulletMarker
@onready var animator: AnimationPlayer = $Animator
@onready var arm_sprite: Sprite2D = $ArmPivot/ArmSprite
@onready var animator_2: AnimationPlayer = $Animator2

signal damaged

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	state_machine.init(self)
	attack_state_machine.init(self)	


func _on_health_component_handle_attack(attack: Hitbox, has_died: bool = false) -> void:
	if has_died: 
		state_machine.force_transition("death", attack)
	else: 
		state_machine.force_transition("damaged", attack)


## Fire particles in the direction of the air bullet. 
func _on_aim_fired_weapon(direction) -> void:
	state_machine.force_transition("knockback", direction)
	arm_pivot.fire_particles()


func die(): 
	state_machine.disabled = true 
	attack_state_machine.disabled = true 
	Events.player_died.emit()


	
	
	
	
