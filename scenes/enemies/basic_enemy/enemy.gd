extends CharacterBody2D

const SPEED = 20
const DUST_PARTICLE = preload("res://scenes/dust_particles/dust_particle.tscn")

@onready var state_machine: Node = $StateMachine
@onready var sprite_2d: Sprite2D = $General/Sprite
@onready var animator: AnimationPlayer = $General/Animator
@onready var hurt_hit_box: HurtHitBox = $Components/HurtHitBox


var facing_right: bool = true 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	state_machine.init(self)


func _on_health_component_handle_attack(attack: Hitbox, has_died: bool = false) -> void:	
	if has_died: 		
		state_machine.force_transition("death", attack)
	else: 
		state_machine.force_transition("damaged", attack)


func disable_hitbox():
	hurt_hit_box.monitorable = false 
	hurt_hit_box.monitoring = false 
		
