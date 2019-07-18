extends Spatial

func _ready():
	# Find the interface and initialise
	var arvr_interface = ARVRServer.find_interface("Oculus")
	if arvr_interface and arvr_interface.initialize():
		get_viewport().arvr = true
		
		# make sure vsync is disabled or we'll be limited to 60fps
		OS.vsync_enabled = false
		
		# up our physics to 90fps to get in sync with our rendering
		Engine.target_fps = 90

func _on_Sliding_door_02_slide_door(new_position):
	$Rooms/Room_02.set_door_position(new_position)
