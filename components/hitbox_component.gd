extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent
@export var attack_component: AttackComponent


func damage(attack: AttackComponent): 
	if health_component: 
		health_component.take_damage(attack)

