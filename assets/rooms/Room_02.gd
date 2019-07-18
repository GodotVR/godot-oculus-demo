extends Spatial

export (NodePath) var arvr_camera = null
export (NodePath) var left_controller = null
export (NodePath) var right_controller = null

var player_head_node = null
var left_hand_node = null
var right_hand_node = null

func set_door_position(new_position):
	$Mirrored/Doors/Left_Door.transform.origin.z = -new_position
	$Mirrored/Doors/Right_Door.transform.origin.z = new_position

func _ready():
	player_head_node = $Mirrored/Player/Head
	left_hand_node = $Mirrored/Player/Left_hand
	right_hand_node = $Mirrored/Player/Right_hand

func _process(delta):
	if !visible:
		set_process(false)
		return
	
	if player_head_node and arvr_camera:
		var player_transform = get_node(arvr_camera).global_transform
		player_transform.origin -= global_transform.origin
		player_head_node.transform = player_transform

	if left_hand_node and left_controller:
		var hand_transform = get_node(left_controller).global_transform
		hand_transform.origin -= global_transform.origin
		left_hand_node.transform = hand_transform

	if right_hand_node and right_controller:
		var hand_transform = get_node(right_controller).global_transform
		hand_transform.origin -= global_transform.origin
		right_hand_node.transform = hand_transform

func _on_body_entered(body):
	# assume player for now..
	visible = true
	set_process(true)

func _on_body_exited(body):
	# assume player for now..
	visible = false
	set_process(false)
