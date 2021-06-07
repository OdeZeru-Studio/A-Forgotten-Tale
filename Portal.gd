extends Area2D

export (String, FILE) var next_scene



func _on_Portal_body_entered(body):
	if "Player" in body.name:
		if not next_scene:
			print("Error: No next scene found")
		else:
			get_tree().change_scene(next_scene)
