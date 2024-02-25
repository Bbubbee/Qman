extends Area2D
class_name Hurtbox

# Rememeber to:
#	- Set masks => these are the colliders that can hurt you. 
#   - Attach a health component to this node.  

@export var health_component: HealthComponent

func _on_hitbox_entered(hitbox: Hitbox) -> void:
	if not hitbox and not health_component: return 
	
	# Set the direction of the hitbox. 
	#print(hitbox.global_position)
	
	health_component.take_damage(hitbox)
		
	
