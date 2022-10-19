extends Node

var node_creation_parent = null
var player = null
var score = 0 
var camera = null
var Highscore = 0


func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func save():
	var save_dic = {
		"Highscore" : Highscore,
	}
	return save_dic

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save",File.WRITE)
	save_game.store_line(to_json(save()))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		print("error save")
		return
		
	save_game.open("user://savegame.save", File.READ)
	
	var Current_line = parse_json(save_game.get_line())
	
	Highscore = Current_line ["Highscore"]
	save_game.close()
