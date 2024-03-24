extends Node2D


const BABY = preload("res://scenes/enemies/baby/baby.tscn")
@onready var baby_spawn_marker = $BabySpawnMarker
@export var actors: Node2D
@onready var animator = $Animator

@onready var pregnant_timer = $PregnantTimer
@onready var idle_timer = $IdleTimer
@onready var hurt_hit_box = $HurtHitBox


func _ready():
	hurt_hit_box.collision_layer = 4 
	hurt_hit_box.collision_mask = 8
	

func _on_idle_timer_timeout():
	animator.play("pregnant")
	pregnant_timer.start() 
	


func _on_pregnant_timer_timeout():
	animator.play("spit")
	

## Will give birth within the animation "spit". 
func give_birth():
	if actors:
		var baby = BABY.instantiate()
		baby.global_position = baby_spawn_marker.global_position
		actors.add_child(baby)

	
## After the spitter gives birth, it will go back to idle. 
func _on_animator_animation_finished(anim_name):
	if anim_name == "spit":
		animator.play("idle")
		idle_timer.start()
		

## The spitter has taken damage. Ouch! 
func _on_health_component_handle_attack(attack, has_died):
	print("ouchies")
	if has_died: 
		queue_free()
