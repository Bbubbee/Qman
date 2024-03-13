extends State

func enter(_enter_params = null):
	actor.animator.play("idle")
	actor.velocity = Vector2.ZERO
