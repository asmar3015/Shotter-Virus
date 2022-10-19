extends Label

func _ready():
	Global.load_game()
	text = String (Global.Highscore)
	
func _process(delta):
	if Global.score > Global.Highscore:
		Global.Highscore = Global.score
