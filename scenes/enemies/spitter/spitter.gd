extends Node2D


const BABY = preload("res://scenes/enemies/baby/baby.tscn")
@onready var baby_spawn_marker = $BabySpawnMarker
@onready var babies: Node = $Babies

@onready var animator = $Animator
@onready var animator_2 = $Animator2

@onready var pregnant_timer = $PregnantTimer
@onready var idle_timer = $IdleTimer
@onready var hurt_hit_box = $HurtHitBox

@export var max_babies: int = 2


func _ready():
	hurt_hit_box.collision_layer = 4 
	hurt_hit_box.collision_mask = 8


## It's time to get pregnant. 
## Only get pregnant if the max number of babies hasn't been reached. 
func _on_idle_timer_timeout():
	if babies.get_child_count() < max_babies: 
		animator.play("pregnant")
		pregnant_timer.start() 
	else: 
		idle_timer.start()  # Keep idling. 


## It's time to give birth.
func _on_pregnant_timer_timeout():
	animator.play("birth")


## Will give birth during the animation "birth". 
func give_birth():
	var baby = BABY.instantiate()
	baby.position = baby_spawn_marker.global_position 
	babies.add_child(baby)



## After the spitter gives birth, it will go back to idle. 
func _on_animator_animation_finished(anim_name):
	if anim_name == "birth":
		animator.play("idle")
		idle_timer.start()
		

## The spitter has taken damage. Ouch! 
func _on_health_component_handle_attack(attack, has_died):
	animator_2.play("hurt")
	if has_died: 
		call_deferred("death", attack)


## The spitter has died. 
## Function made so that the signal can be emitted deferred. 
func death(attack): 
	Events.spawn_particles.emit(position, 30, attack.direction)
	queue_free()


func _on_animator_2_animation_finished(anim_name):
	if anim_name == "hurt":
		animator_2.play("RESET")
