extends CharacterBody2D

const SPEED = 20

@onready var attack_component: AttackComponent = $Components/AttackComponent
@onready var state_machine: Node = $StateMachine
@onready var sprite_2d: Sprite2D = $General/Sprite
@onready var animator: AnimationPlayer = $General/Animator

var attack_incoming: AttackComponent = null 
var has_died: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	state_machine.init(self)


