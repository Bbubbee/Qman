extends State

const GUST = preload('res://scenes/player/actions/gust.tscn')
signal fired_weapon(direction: Vector2)
var can_shoot: bool = true
@onready var attack_timer: Timer = $AttackTimer


func physics_process(_delta: float):
	var mouse_pos = actor.get_global_mouse_position()
	mouse_pos.x = floor(mouse_pos.x)
	mouse_pos.y = floor(mouse_pos.y)
	
	var pos = actor.global_position
	
	# Make the arm aim at the mouse. 
	actor.arm_pivot.look_at(mouse_pos)
	
	# Flip the sprite to face the correct direction.
	if mouse_pos.x > pos.x:
		actor.sprite.flip_h = false
		actor.arm_sprite.flip_h = false
		actor.arm_pivot.position.x = -1
	else: 
		actor.sprite.flip_h = true
		actor.arm_sprite.flip_h = true
		actor.arm_pivot.position.x = 1

func on_input(event: InputEvent) -> void:
	if event.is_action_pressed('spit'):
		if can_shoot: 
			can_shoot = false
			attack_timer.start()
			
			var gust = GUST.instantiate()
			
			var direction = (actor.get_global_mouse_position() - actor.global_position).normalized()
			gust.init(direction, actor.bullet_marker.global_position)
			
			var root = get_tree().get_root()
			root.add_child(gust)
			
			fired_weapon.emit(direction)


func _on_attack_timer_timeout() -> void:
	can_shoot = true
