extends Node2D


"""
	The babies are stored within the spitter to track how many babies the 
	spitter has made. 
	
	This is to prevent it from spawning an unlimited amount. 
"""
const BABY = preload("res://scenes/enemies/baby/baby.tscn")
@onready var baby_spawn_marker = $BabySpawnMarker
@onready var babies: Node = $Babies
@export var max_babies: int = 2
@onready var num_of_babies: int = max_babies

@onready var animator = $Animator
@onready var animator_2 = $Animator2

@onready var pregnant_timer = $PregnantTimer
@onready var idle_timer = $IdleTimer
@onready var hurt_hit_box = $HurtHitBox

@onready var sprite: Sprite2D = $Sprite
var is_alive: bool = true

signal everyones_defeated
	# Signal used in the case that the spitter is part of a trap room. 
	# A trap room unlocks when all enemies are defeated. 

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
	baby.died.connect(on_baby_died)
	babies.add_child(baby)
	
	
## A baby has been defeated. Check if the parent should free itself. 
func on_baby_died():
	num_of_babies -= 1 
	check_if_should_free()


## After the spitter gives birth, it will go back to idle. 
func _on_animator_animation_finished(anim_name):
	if anim_name == "birth":
		animator.play("idle")
		idle_timer.start()


## Handles the hurt animation. 
func _on_animator_2_animation_finished(anim_name):
	if anim_name == "hurt":
		animator_2.play("RESET")
		

## The spitter has taken damage. Ouch! 
func _on_health_component_handle_attack(attack, has_died):
	animator_2.play("hurt")
	if has_died: 
		call_deferred("death", attack)


## The spitter has died. 
## Function made so that the signal can be emitted deferred. 
func death(attack): 
	Events.spawn_particles.emit(global_position, 30, attack.direction)
	hurt_hit_box.disable()
	sprite.visible = false
	is_alive = false 
	pregnant_timer.stop()
	idle_timer.stop()
	animator.play("RESET")
	animator_2.play("RESET")
	
	check_if_should_free()
	

## Only free the spitter if the babies are also defeated. 
func check_if_should_free(): 
	if num_of_babies > 0: return
	if is_alive: return
	
	# Used in the case the spitter is part of a trap room. 
	everyones_defeated.emit()
	
	queue_free()
	

