extends Panel

@onready var animation_player = $AnimationPlayer

var depleted: bool = false

func regenerate_heart(): 
	depleted = false 
	animation_player.play("regenerate")

func deplete_heart(): 
	depleted = true
	animation_player.play("deplete")

## A new player is created whenever they transition scenes. 
## They may have lost hearts before they did. 
## This spawns the heart as depleted already. 
func spawn_depleted(): 
	depleted = true
	animation_player.play("already_depleted")
