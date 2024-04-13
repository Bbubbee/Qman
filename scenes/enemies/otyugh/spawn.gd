extends State


func enter(_enter_params = null):
	actor.sprite.visible = false 
	actor.hurt_hit_box.disable()
	
	
# Let actor spawn when it wants to. 
func spawn(): 
	
	actor.hurt_hit_box.call_deferred("enable")
	
	actor.animator_2.play("spawn")
	actor.sprite.visible = true
	
	await actor.animator_2.animation_finished
	transition.emit(self, "idle")
	
	

