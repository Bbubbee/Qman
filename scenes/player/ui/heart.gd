extends Panel

@onready var animation_player = $AnimationPlayer

var depleted: bool = false

func deplete_heart(): 
	depleted = true
	animation_player.play("deplete")

