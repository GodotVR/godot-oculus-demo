extends Spatial

signal slide_door(new_position)

export var door_speed = 10.0
var wanted_door_position = 1.0

func _process(delta):
	var new_door_position = $Doors/Right_door.transform.origin.x
	if  new_door_position > wanted_door_position:
		new_door_position -= delta * door_speed
		if new_door_position < wanted_door_position:
			new_door_position = wanted_door_position
			set_process(false)
	else:
		new_door_position += delta * door_speed
		if new_door_position > wanted_door_position:
			new_door_position = wanted_door_position
			set_process(false)
	
	$Doors/Right_door.transform.origin.x = new_door_position
	$Doors/Left_door.transform.origin.x = -new_door_position
	
	emit_signal("slide_door", new_door_position)

func _on_body_entered(body):
	# assume player, open doors
	wanted_door_position = 2.9
	set_process(true)
	$Door_sound.playing = true

func _on_body_exited(body):
	# assume player, close doors
	wanted_door_position = 1
	set_process(true)
	$Door_sound.playing = true
