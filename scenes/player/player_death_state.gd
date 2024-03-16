extends State


func enter(_enter_params = null):
	actor.animator.play("death")
	actor.die()

