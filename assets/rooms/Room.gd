extends Spatial

func _on_body_entered(body):
	# assume player for now..
	visible = true

func _on_body_exited(body):
	# assume player for now..
	visible = false
