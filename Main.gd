extends Spatial

func _ready():
	# Hide rooms player is not in by default, we don't hide our doors or corridors
	$Rooms/Room_02.visible = false
	$Rooms/Room_03.visible = false
	
	# Find the interface and initialise
	var arvr_interface = ARVRServer.find_interface("Oculus")
	if arvr_interface and arvr_interface.initialize():
		get_viewport().arvr = true
		
		# make sure vsync is disabled or we'll be limited to 60fps
		OS.vsync_enabled = false
		
		# up our physics to 90fps to get in sync with our rendering
		Engine.iterations_per_second = 90

func _on_Sliding_door_02_slide_door(new_position):
	$Rooms/Room_02.set_door_position(new_position)
