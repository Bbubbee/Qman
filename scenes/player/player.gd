extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -250.0

@onready var arm_pivot: Marker2D = $ArmPivot
@onready var state_machine: Node = $StateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

	# Make the arm and gun aim at the mouse. 
	arm_pivot.look_at(get_global_mouse_position())







