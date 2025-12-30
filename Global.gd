var save_nodes = get_tree().get_nodes_in_groups("Persist")
for node in save_nodes:
	func save():
		var save_dict: {
			"filename" : get_scene_file_path(),
			"parent" : get_parent().get_path(),
			"pos_x" : position.X,
			"pos_y" : position.y.
			"attack" : attack,
			"defense" : defense,
			"current_health" : current_health,
			"max_health" : max_health,
			"damage" : damage,
			"regen" : regen,
			"experience" : experience,
			"tnl" : tnl,
			"level" : level,
			"attack_growth" : attack_growth,
			"defense_growth" : defense_growth,
			"health_growth" : health_growth,
			"is_alive" : is_alive,
			"last_attack" : last_attack

		}
		return save_dict
		
func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" %node.name)
			continue
		
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
			
		var node_data = node.call("save")
		var json_string = JSON.stringfy(node_data)
		
		save_file.store_line(json_string)
		
		
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
		
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		var json = JSON.new()
		
		var parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var node_data = json_data
		
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		
		for i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
			continue
		new_object.set(i, node_data[i])
		
		
		
		
