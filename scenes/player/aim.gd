extends State

const GUST = preload('res://scenes/player/actions/gust.tscn')

func physics_process(_delta: float):
	var mouse_pos = actor.get_global_mouse_position()
	var pos = actor.global_position
	
	# Make the arm aim at the mouse. 
	actor.arm_pivot.look_at(mouse_pos)
	
	# Face the sprite towards the mouse.
	actor.sprite.flip_h = mouse_pos.x < pos.x 
	

func on_input(event: InputEvent) -> void:
	if event.is_action_pressed('spit'):
		var gust = GUST.instantiate()
		
		var direction = actor.get_global_mouse_position() - actor.global_position
		gust.global_position = actor.bullet_marker.global_position
		gust.direction = direction.normalized()
		
		var root = get_tree().get_root()
		root.add_child(gust)
