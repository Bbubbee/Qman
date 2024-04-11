extends DustBall

@onready var sprite = $Sprite


func _ready():
	sprite.visible = false 


func _on_visibility_timer_timeout():
	sprite.visible = true
