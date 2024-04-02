extends GPUParticles2D


func _ready() -> void:
	emitting = true

func init(scale): 

	#scale_min = scale
	process_material.scale_min = scale
	process_material.scale_max = scale
	

func _on_finished() -> void:
	queue_free()
