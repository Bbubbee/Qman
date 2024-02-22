extends Area2D
class_name Hurtbox


func _on_hitbox_entered(hitbox: Hitbox) -> void:
	if not hitbox: return 
	
	print("take damage ")
		
	
