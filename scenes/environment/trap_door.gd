extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var player_detector = $PlayerDetector
@onready var static_body_2d = $StaticBody2D



## The player is in the room. 
## Spawn the door to trap them inside. 
func _on_area_2d_area_entered(area):
	player_detector.queue_free()
	static_body_2d.collision_layer = 1
	animation_player.play("spawn")
	animation_player.queue("idle")
