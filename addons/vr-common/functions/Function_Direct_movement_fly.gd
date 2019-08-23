# Function_Direct_movement_fly.gd
# Author: Alessandro Schillaci
# Date: 2019-08-23
# Version: 1.0
# 
# NOTE:
# This is a modification of the original function from the main asset library by Bastiaan Olij
# Using this, player will be able to move in 4 directions like a WASD FPS Game and will be able 
# to fly using the controller's orientation when the "button 2" and "button 15" are pressed together
#
# In case of the use of the OCULUS RIFT S device, you should set Engine.target_fps = 80 instead of 90
#
# PROCESS:
# if fly_action_button_id is pressed, the FLY MODE is activated
# if fly_action_button_id and fly_button_id are pressed together the VR capsule will fly following the controller's orientation
# if only the fly_action_button_id is pressed then the VR capsule will remain still in air
#
# Thanks to Bastiaan Olij for this wondeful addon

extends Node

# We don't know the name of the camera node... 
export (NodePath) var camera = null

# size of our player
export var player_radius = 0.4 setget set_player_radius, get_player_radius

export var max_speed = 200.0
export var drag_factor = 0.1

# fly mode and strafe movement management
export var fly_button_id = 15
export var fly_action_button_id = 2
var isflying = false

var turn_step = 0.0
var origin_node = null
var camera_node = null
var velocity = Vector3(0.0, 0.0, 0.0)
var gravity = -30.0
onready var collision_shape = get_node("KinematicBody/CollisionShape")
onready var tail = get_node("KinematicBody/Tail")

func get_player_radius():
	return player_radius

func set_player_radius(p_radius):
	player_radius = p_radius

func _ready():
	origin_node = get_node("../..")
	
	if camera:
		camera_node = get_node(camera)
	else:
		camera_node = origin_node.get_node('ARVRCamera')
	
	set_player_radius(player_radius)

func _physics_process(delta):
	if !origin_node:
		return
	
	if !camera_node:
		return
	
	# Adjust the height of our player according to our camera position
	var camera_height = camera_node.transform.origin.y
	if camera_height < player_radius:
		# not smaller than this
		camera_height = player_radius
	
	collision_shape.shape.radius = player_radius
	collision_shape.shape.height = camera_height - player_radius
	collision_shape.transform.origin.y = (camera_height / 2.0) + player_radius
	
	# We should be the child or the controller on which the teleport is implemented
	var controller = get_parent()
	if controller.get_is_active():
		if controller.is_button_pressed(fly_action_button_id):
			isflying =  true
		else:
			isflying = false
		
		if isflying:	
			if controller.is_button_pressed(fly_button_id):
				# is flying, so we will use the controller's transform to move the VR capsule follow its orientation					
				var curr_transform = $KinematicBody.global_transform
				velocity = controller.global_transform.basis.z.normalized() * -delta * max_speed * ARVRServer.world_scale
				velocity = $KinematicBody.move_and_slide(velocity)
				var movement = ($KinematicBody.global_transform.origin - curr_transform.origin)
				origin_node.global_transform.origin += movement
		else:			
			var left_right = controller.get_joystick_axis(0)
			var forwards_backwards = controller.get_joystick_axis(1)
			
			################################################################
			# now we do our movement
			var curr_transform = $KinematicBody.global_transform
			var camera_transform = camera_node.global_transform
			curr_transform.origin = camera_transform.origin
			curr_transform.origin.y = origin_node.global_transform.origin.y
			$KinematicBody.global_transform = curr_transform
			
			# we'll handle gravity separately
			var gravity_velocity = Vector3(0.0, velocity.y, 0.0)
			velocity.y = 0.0
			
			# Apply our drag
			velocity *= (1.0 - drag_factor)
			
			if ((abs(forwards_backwards) > 0.1 ||  abs(left_right) > 0.1) and tail.is_colliding()):
				var dir_forward = camera_transform.basis.z
				dir_forward.y = 0.0
				
				# VR Capsule will strafe left and right
				var dir_right = camera_transform.basis.x;
				dir_right.y = 0.0
				
				velocity = (dir_forward * -forwards_backwards + dir_right * left_right).normalized() * delta * max_speed * ARVRServer.world_scale
			
			# apply move and slide to our kinematic body
			velocity = $KinematicBody.move_and_slide(velocity, Vector3(0.0, 1.0, 0.0))
			
			# apply our gravity
			gravity_velocity.y += gravity * delta
			gravity_velocity = $KinematicBody.move_and_slide(gravity_velocity, Vector3(0.0, 1.0, 0.0))
			velocity.y = gravity_velocity.y
			
			# now use our new position to move our origin point
			var movement = ($KinematicBody.global_transform.origin - curr_transform.origin)
			origin_node.global_transform.origin += movement
			
			# Return this back to where it was so we can use its collision shape for other things too
			# $KinematicBody.global_transform.origin = curr_transform.origin

