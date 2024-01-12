extends Label


var score = 0
var scoreHouse = 0
var Account = 100
var CurrentBet = 0
signal BetPlaced
signal GameLost
signal GameWon
signal GameEnded
signal HouseWantsDraw

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func NewGame():
	CurrentBet = 0
	score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scoreHouse > 21:
		scoreHouse = 0
		GameWon.emit()
	if score > 21 or Account == 0:
		score = 0
		GameLost.emit()
	else:
		text = "current score:\n" + str(score) +\
					"\nAccount:\n" + str(Account) +\
					"\nCurrent Bet:\n" + str(CurrentBet) +\
					"\nHouse score:\n" + str(scoreHouse) 


func _on_main_game_loop_drawn_card_score(value):
	score += value


func _on_main_game_loop_drawn_card_score_house(value):
	if scoreHouse < score:
		HouseWantsDraw.emit()
	scoreHouse += value


func _on_line_edit_text_submitted(new_text):
	if int(new_text) <= Account:
		CurrentBet = int(new_text)
		Account -= int(new_text)
		BetPlaced.emit()
	pass # Replace with function body.


func _on_main_game_loop_new_game():
	NewGame()
	pass # Replace with function body.


