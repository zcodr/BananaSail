extends Node

var high_score : float = 10000
var score : float = 10000

func _ready():
	load_app()

func save():
	var save_dict = {
		"high_score" : high_score
	}
	return save_dict

func save_app():
	var lsave_app = FileAccess.open("user://bananasail.save", FileAccess.WRITE)

	var json_string = JSON.stringify(save())
	
	lsave_app.store_line(json_string)

func load_app():
	if not FileAccess.file_exists("user://bananasail.save"):
		return
	
	var lsave_app = FileAccess.open("user://bananasail.save", FileAccess.READ)
	
	while lsave_app.get_position() < lsave_app.get_length():
		var json_string = lsave_app.get_line()
		var json = JSON.new()
		var _parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		high_score = node_data["high_score"]
		
#func _ready():
	#load_app()
#
#func save():
	#var save_dict = {
		#"high score" : high_score
	#}
	#return save_dict
#
#func save_app():
	#var file : File = File.new()
	#var _k = file.open("user://saveapp.save", File.WRITE)
	#file.store_var(high_score)
	#file.close()
#
#func load_app():
	#var file = File.new()
	#if not file.file_exists("user://saveapp.save"):
		#return
	#file.open("user://saveapp.save", File.READ)
	#high_score = file.get_var()
	#file.close()
