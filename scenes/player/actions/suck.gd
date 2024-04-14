extends Node2D

@onready var area_2d = $Area2D
var force = 20
var is_sucking: bool = false
@onready var collection_zone = $CollectionZone
@onready var player = $"../../.."

@onready var vacuum = $"../../Audio/Vacuum"

var play_sound_once = false

func suck(direction: Vector2): 
	var bodies = area_2d.get_overlapping_bodies()
	is_sucking = true
	for i in bodies: 
		i.apply_central_force(-(direction*force))

func _physics_process(delta):
	if play_sound_once: 
		vacuum.play()
		play_sound_once = false 
		


func _on_collection_zone_body_entered(body):
	if not is_sucking: return
	if not body is DustParticle: return
	
	PlayerStats.dust_particles += 1
	Globals.play_zap_sfx()
	body.queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('suck'):
		play_sound_once = true 
	if event.is_action_released('suck'):
		
		await get_tree().create_timer(0.25).timeout
		is_sucking = false
		vacuum.stop() 
