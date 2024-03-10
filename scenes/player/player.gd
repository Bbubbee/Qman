extends CharacterBody2D
class_name Player


const SPEED = 180.0
const acceleration: float = 20.0
const friction: float = 25.0

@onready var arm_pivot: Marker2D = $ArmPivot
@onready var state_machine: Node = $StateMachine
@onready var attack_state_machine: Node = $AttackStateMachine
@onready var sprite: Sprite2D = $Sprite
@onready var bullet_marker: Marker2D = $ArmPivot/BulletMarker
@onready var animator: AnimationPlayer = $Animator
@onready var arm_sprite: Sprite2D = $ArmPivot/ArmSprite

signal damaged

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	state_machine.init(self)
	attack_state_machine.init(self)
#
#func _physics_process(delta: float) -> void:
	#move_and_slide()
	#for i in get_slide_collision_count():
		#var c = get_slide_collision(i)
		#if c.get_collider() is RigidBody2D:
			#c.get_collider().apply_central_impulse(-c.get_normal() * 20)
	

func _on_health_component_handle_attack(attack: Hitbox, _has_died: bool = false) -> void:
	state_machine.force_transition("damaged", attack)


## Fire particles in the direction of the air bullet. 
func _on_aim_fired_weapon(direction) -> void:
	state_machine.force_transition("knockback", direction)
	arm_pivot.fire_particles()
	
