extends CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine = $StateMachine
@onready var sprite = $Misc/Sprite

## Components. 
@onready var velocity_component = $Components/VelocityComponent


func _ready():
	state_machine.init(self) 

func _physics_process(delta):
	handle_gravity(delta)
	
	# Move right. 
	


"""
	State Machine Logic
"""

func face_direction(direction: String): 
	if direction.to_lower() == "right": 
		pass

func handle_gravity(delta): 
	if not is_on_floor(): velocity.y += gravity * delta
