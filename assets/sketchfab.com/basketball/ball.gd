extends "res://addons/vr-common/objects/Object_pickable.gd"

func _update_highlight():
	if closest_count > 0:
		$Hilight.visible=true
	else:
		$Hilight.visible=false

