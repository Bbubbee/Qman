extends Area2D
class_name Hurtbox

# Rememeber to:
#	- Set masks => these are the colliders that can hurt you. 
#   - Attach a health component to this node.  

@export var health_component: HealthComponent

signal im_hit 

func _on_hitbox_entered(hitbox: Hitbox) -> void:
	im_hit.emit() 
	if not hitbox or not health_component: return 
	
	health_component.take_damage(hitbox)
		
	
