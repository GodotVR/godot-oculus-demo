extends "res://assets/rooms/Room.gd"

func _ready():
	$Exteriour_mockup.visible = false

func _on_Check_If_Player_Can_See_Exteriour_body_entered(body):
	$Exteriour_mockup.visible = true

func _on_Check_If_Player_Can_See_Exteriour_body_exited(body):
	$Exteriour_mockup.visible = false
