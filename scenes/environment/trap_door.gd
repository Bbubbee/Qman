extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var static_body_2d = $StaticBody2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2

signal destroyed


func _ready() -> void:
	hurtbox.monitoring = false
	hurtbox.monitorable = false


## Spawn the door to trap the player inside. 
func spawn_door(): 
	static_body_2d.collision_layer = 1
	animation_player.play("spawn")
	animation_player.queue("idle")
	


func disable(): 
	animation_player.play("death")
	hurtbox.monitoring = true
	hurtbox.monitorable = true



func _on_health_component_handle_attack(attack: Hitbox, has_died: bool) -> void:
	if has_died: 
		call_deferred("particle_ass_booty", attack)
		destroyed.emit()
		queue_free()
	else: 
		animation_player_2.play("hurt")

func particle_ass_booty(attack): 
	Events.spawn_particles.emit(self.global_position, 20, attack.direction)
