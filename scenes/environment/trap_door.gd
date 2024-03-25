extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var static_body_2d = $StaticBody2D


## Spawn the door to trap the player inside. 
func spawn_door(): 
	static_body_2d.collision_layer = 1
	animation_player.play("spawn")
	animation_player.queue("idle")

