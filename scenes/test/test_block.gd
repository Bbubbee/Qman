extends RigidBody2D

var force 
var dir 

# Called when the node enters the scene tree for the first time.
func _ready():
	force = Vector2(150, 0)
	dir = Vector2.RIGHT


#func _input(event):
	#if event.is_action_pressed("jump"):
		#apply_impulse(force, dir)
		#print("calling apply impulse")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#apply_force(force, dir)
