extends DustParticle


var force = 300

func _ready() -> void:	
	apply_central_impulse(direction*force)
