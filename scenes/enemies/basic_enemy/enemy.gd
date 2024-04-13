extends CharacterBody2D

signal died 

## Global resources 
const UNITS = preload("res://utilitites/resources/units.tres")

const SPEED = 20
const DUST_PARTICLE = preload("res://scenes/dust_particles/dust_particle.tscn")

@onready var state_machine: Node = $StateMachine
@onready var sprite_2d: Sprite2D = $General/Sprite
@onready var animator: AnimationPlayer = $General/Animator
@onready var hurt_hit_box: HurtHitBox = $Components/HurtHitBox
@onready var floor_detector_ray = $General/FloorDetectorRay
@onready var state_label = $General/StateLabel


var facing_right: bool = true 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	state_machine.init(self)
	
	Events.player_died.connect(disable)
	

func _on_health_component_handle_attack(attack: Hitbox, has_died: bool = false) -> void:	
	call_deferred("play_sound_effect")
	if has_died: state_machine.force_transition("death", attack)
	else: state_machine.force_transition("damaged", attack)


func disable_hitbox():
	hurt_hit_box.monitorable = false 
	hurt_hit_box.monitoring = false 


func disable(): 
	state_machine.force_transition("wander")


func _physics_process(_delta):
	face_player()


func face_player():
	if facing_right: 
		sprite_2d.flip_h = true
		floor_detector_ray.scale.x = 1
	else:
		sprite_2d.flip_h = false 
		floor_detector_ray.scale.x = -1
		
func handle_gravity(delta): 
	if not is_on_floor(): velocity.y += gravity * delta


func spawn_particles(amount, direction): 
	Events.spawn_particles.emit(self.global_position, amount, direction)

@onready var hit = $General/Audio/Hit
func play_sound_effect(): 
	hit.play()
	
	
	
		
		
