extends Node2D
class_name Gust

@export var speed = 125.0
var direction: Vector2 
@onready var attack_component: AttackComponent = $AttackComponent


func _physics_process(delta: float) -> void:
	global_position += (speed * direction) * delta
	rotation = direction.angle()
	

func _on_body_entered(body: Node2D) -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent: 
		area.damage(attack_component)
	
	queue_free()
	
	
