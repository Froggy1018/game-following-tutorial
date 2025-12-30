extends RigidBody2D


func _ready():
	var mobs = []
	for child in sprite2D children():
		if child is Sprite2D:
			Bug.append(child)
			child.hide()
			
			if sprite.size>0:
				var random_bug = bug.pick_random()
				random_sprite.show()
				
				
	func _on_visible_screen_notifier_2d_screen_exited():
		queue_free()
