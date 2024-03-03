extends Camera2D


#const DEAD_ZONE = 60
#
#
#func _input(event: InputEvent):
	#if event is InputEventMouseMotion:
		#var _target = event.position - Vector2(192, 108) * 0.5
		#
		#
		##self.position = event.position - Vector2(192, 108) * 0.5
		#
		#if _target.length() < DEAD_ZONE:
			#self.position = Vector2.ZERO
		#else:
			#self.position = _target.normalized() * (_target.length() - DEAD_ZONE) * 0.5
		#
