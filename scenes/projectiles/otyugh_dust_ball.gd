extends DustBall

@onready var sprite = $Sprite
@onready var hitbox = $Hitbox


func _ready():
	sprite.visible = false 


func _on_visibility_timer_timeout():
	sprite.visible = true
	hitbox.monitorable = true
	hitbox.monitoring = true
	
