extends CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine = $StateMachine
@onready var sprite = $Misc/Sprite
const UNITS = preload("res://utilitites/resources/units.tres")
@onready var animator = $Misc/Animator

## Components. 
@onready var velocity_component = $Components/VelocityComponent



func _ready():
	state_machine.init(self) 


func _physics_process(delta):
	face_forward()

"""
	State Machine Accessible Functions
"""

func face_forward(): 
	if velocity.x > 0: 
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

# Forcibly position the sprite. Used during spit attacks.
func face_right(right: bool): 
	sprite.flip_h = not right

func get_direction_of_player(): 
	if not UNITS.player: return
	
	var dir = global_position.x - UNITS.player.global_position.x
	if dir > 0: 
		return Vector2.RIGHT
	else:
		return Vector2.LEFT 
	
	


func can_detect_player(): 
	var player = UNITS.player
	if not player: return false
	
	# Check if within range of player. 
	var distance = (player.global_position - self.global_position).length()
	
	if distance < 100: return true 
	else: return false

func handle_gravity(delta): 
	if not is_on_floor(): velocity.y += gravity * delta

func _on_health_component_handle_attack(_attack, has_died):
	if has_died: queue_free()


# TODO: Health bar
