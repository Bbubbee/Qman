extends GPUParticles2D


func _ready() -> void:
	emitting = true

func init(size): 
	process_material.scale_min = size
	process_material.scale_max = size
	

func _on_finished() -> void:
	queue_free()
