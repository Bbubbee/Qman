extends Node2D
class_name Gust

@export var speed = 125.0
@onready var hitbox = $Hitbox

var direction: Vector2 

# Force for knocking back particles. 
@export var force = 1300


# NOTE: Must call AFTER adding this node to the tree.
# This is because we need the hitbox to ready before initialising. 
# Can't initialise a null node. 
func init(dir: Vector2, pos: Vector2, dmg: float, knockback: float): 
	self.direction = dir
	self.global_position = pos 
	self.hitbox.damage = dmg
	self.hitbox.knockback = knockback
	

func _physics_process(delta: float) -> void:
	# Fly in a given direction and rotation. 
	global_position += (speed * direction) * delta
	rotation = direction.angle()
	
	
	# Blow back dust particles. 
	var bodies = hitbox.get_overlapping_bodies()
	for i in bodies:
		if i is DustParticle:
			# If the direction goes directly into the ground, 
			# flip it so it bounces up instead. 
			var y = direction.y
			if y > 0: y = -y
			
			i.apply_central_force(Vector2(direction.x*force, y*force))
	


func _on_timer_timeout() -> void:
	queue_free()


