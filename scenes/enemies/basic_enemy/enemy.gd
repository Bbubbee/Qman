extends CharacterBody2D

const SPEED = 20

@onready var state_machine: Node = $StateMachine
@onready var sprite_2d: Sprite2D = $General/Sprite
@onready var animator: AnimationPlayer = $General/Animator

var has_died: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	state_machine.init(self)


func _on_health_component_handle_attack(attack: Hitbox) -> void:
	state_machine.force_transition("damaged", attack)
