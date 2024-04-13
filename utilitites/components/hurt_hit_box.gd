class_name HurtHitBox
extends Hitbox
# Should also extend Hurtbox. Since we can't do that, 
# just add the Hurtbox code here. 

# Note:
# For collisions, this node must have a layer and mask.
# Layer - hitbox.  Looks for things to hit. 
# Mask  - hurtbox. Looks for thing to hurt it. 


@export var health_component: HealthComponent

	
func disable(): 
	monitorable = false 
	monitoring = false

func enable(): 
	monitorable = true 
	monitoring = true

func _on_hitbox_entered(hitbox: Hitbox):
	if not hitbox: return 
	if health_component: health_component.take_damage(hitbox)
	else:
		queue_free()
