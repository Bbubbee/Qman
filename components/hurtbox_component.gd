extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent
@export var attack_component: AttackComponent


## Called in other nodes. 
func damage(attack: AttackComponent): 
	if health_component: 
		health_component.take_damage(attack)


## Called when another node touches this. 
func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
