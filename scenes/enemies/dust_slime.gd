extends CharacterBody2D

const SPEED = 20
const JUMP_VELOCITY = -400.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var attack_component: AttackComponent = $Components/AttackComponent

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = -1 * SPEED

	sprite_2d.flip_h = velocity.x > 0

	
	move_and_slide()


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		area.damage(attack_component)
