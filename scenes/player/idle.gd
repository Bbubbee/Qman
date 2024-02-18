extends State


func enter(): 
	actor.velocity.x = 0


func on_input(event: InputEvent):	
	var moving = Input.get_axis('left', 'right')
	if moving: transition.emit(self, "move") 
		

