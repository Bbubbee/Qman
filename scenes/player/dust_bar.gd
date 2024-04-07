extends ProgressBar


func _ready():
	PlayerStats.dust_particles_changed.connect(display_new_dust_particles_number)
	value = PlayerStats.dust_particles


func display_new_dust_particles_number(val): 
	value = val
