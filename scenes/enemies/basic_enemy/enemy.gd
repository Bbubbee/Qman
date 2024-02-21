extends CharacterBody2D

const SPEED = 20

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var attack_component: AttackComponent = $Components/AttackComponent
@onready var state_machine: Node = $StateMachine
@onready var animator: AnimationPlayer = $Animator

var attack_incoming: AttackComponent = null 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	state_machine.init(self)
	

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		area.damage(attack_component)


