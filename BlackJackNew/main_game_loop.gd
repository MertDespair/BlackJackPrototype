extends Node2D

var Lost_scene = preload("res://Lost_Screen.tscn")
var Win_scene = preload ("res://Win_screen.tscn")

var CardsOnHand = 0
var CardsOnHouse = 0
var DrawnCard
var GameState = 0
var ClickedOnDeck = false
var HouseHasDrawn = true
var GameLost = false
var GameWon = false
var HouseWantsDraw = true

var CardDeck = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
				 17, 18, 19,20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
				 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				 45, 46, 47, 48, 49, 50, 51, 52]

var DeckValue = [1,2,3,4,5,6,7,8,9,10,11,12,13,
				1,2,3,4,5,6,7,8,9,10,11,12,13,
				1,2,3,4,5,6,7,8,9,10,11,12,13,
				1,2,3,4,5,6,7,8,9,10,11,12,13]

var DeckTexture = ["card-clubs-1", "card-clubs-2", "card-clubs-3", "card-clubs-4",
 "card-clubs-5", "card-clubs-6", "card-clubs-7", "card-clubs-8", "card-clubs-9",
 "card-clubs-10", "card-clubs-11", "card-clubs-12", "card-clubs-13", "card-diamonds-1",
 "card-diamonds-2", "card-diamonds-3", "card-diamonds-4", "card-diamonds-5",
 "card-diamonds-6", "card-diamonds-7", "card-diamonds-8", "card-diamonds-9",
 "card-diamonds-10", "card-diamonds-11", "card-diamonds-12", "card-diamonds-13",
 "card-hearts-1", "card-hearts-2", "card-hearts-3", "card-hearts-4", "card-hearts-5",
 "card-hearts-6", "card-hearts-7", "card-hearts-8", "card-hearts-9", "card-hearts-10",
 "card-hearts-11", "card-hearts-12", "card-hearts-13", "card-spades-1", "card-spades-2",
 "card-spades-3", "card-spades-4", "card-spades-5", "card-spades-6", "card-spades-7",
 "card-spades-8", "card-spades-9", "card-spades-10", "card-spades-11", "card-spades-12",
 "card-spades-13"]

#signal CardDrawn
signal PlayerHandFull
signal HouseHandFull
signal DrawnCardScore(value)
signal DrawnCardScoreHouse(value)
signal PlayAnimation
signal PlayAnimationHouse
signal NewGame

func GameRestart():
	
	
	if GameLost:
		var Lost_instance = Lost_scene.instantiate()
		add_child(Lost_instance)
		await get_tree().create_timer(1).timeout
		remove_child(Lost_instance)
	
	if GameWon:
		var Win_instance = Win_scene.instantiate()
		add_child(Win_instance)
		await get_tree().create_timer(1).timeout
		remove_child(Win_instance)
	
	CardDeck = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
				 17, 18, 19,20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
				 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				 45, 46, 47, 48, 49, 50, 51, 52]
	
	CardDeck.shuffle()
	
	$PlayerHand/Card1.texture = null
	$PlayerHand/Card2.texture = null
	$PlayerHand/Card3.texture = null
	$PlayerHand/Card4.texture = null
	$PlayerHand/Card5.texture = null
	$PlayerHand/Card6.texture = null
	$PlayerHand/Card7.texture = null
	$PlayerHand/Card8.texture = null
	
	$HouseHand/Card1.texture = null
	$HouseHand/Card2.texture = null
	$HouseHand/Card3.texture = null
	$HouseHand/Card4.texture = null
	$HouseHand/Card5.texture = null
	$HouseHand/Card6.texture = null
	$HouseHand/Card7.texture = null
	$HouseHand/Card8.texture = null
	
	GameState = 0
	CardsOnHand = 0
	CardsOnHouse = 0
	GameLost = false
	GameWon = false
	NewGame.emit()


func DrawCard():
	#CardDrawn.emit()
	return CardDeck.pop_front()


# Called when the node enters the scene tree for the first time.
func _ready():
	CardDeck.shuffle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not GameLost and not GameWon:
		if ClickedOnDeck and GameState == 1:
			DrawnCard = DrawCard()
			PlayAnimation.emit()
			ClickedOnDeck = false
		if GameState == 2 and HouseHasDrawn and HouseWantsDraw:
			DrawnCard = DrawCard()
			PlayAnimationHouse.emit()
			HouseHasDrawn = false
			HouseWantsDraw = false
	else:
		GameRestart()
		
	

func _on_deck_click_on_deck():
	ClickedOnDeck = true
	pass # Replace with function body.

#Logic to load the different sprites depending on the drawn card

func _on_animation_player_card_move_finish():
	CardsOnHand += 1
	match CardsOnHand:
		1:
			DrawnCardScore.emit(DeckValue[DrawnCard-1])
			$PlayerHand/Card1.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		2:
			DrawnCardScore.emit(DeckValue[DrawnCard-1])
			$PlayerHand/Card2.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		3:
			DrawnCardScore.emit(DeckValue[DrawnCard-1])
			$PlayerHand/Card3.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		4:
			DrawnCardScore.emit(DeckValue[DrawnCard-1])
			$PlayerHand/Card4.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		5:
			DrawnCardScore.emit(DeckValue[DrawnCard-1])
			$PlayerHand/Card5.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		6:
			DrawnCardScore.emit(DeckValue[DrawnCard-1])
			$PlayerHand/Card6.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		7:
			DrawnCardScore.emit(DeckValue[DrawnCard-1])
			$PlayerHand/Card7.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		8:
			DrawnCardScore.emit(DeckValue[DrawnCard-1])
			PlayerHandFull.emit()
			$PlayerHand/Card8.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		




func _on_house_draw_card_move_finish():
	CardsOnHouse += 1
	match CardsOnHouse:
		1:
			HouseHasDrawn = true
			DrawnCardScoreHouse.emit(DeckValue[DrawnCard-1])
			$HouseHand/Card1.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		2:
			HouseHasDrawn = true
			DrawnCardScoreHouse.emit(DeckValue[DrawnCard-1])
			$HouseHand/Card2.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		3:
			HouseHasDrawn = true
			DrawnCardScoreHouse.emit(DeckValue[DrawnCard-1])
			$HouseHand/Card3.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		4:
			HouseHasDrawn = true
			DrawnCardScoreHouse.emit(DeckValue[DrawnCard-1])
			$HouseHand/Card4.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		5:
			HouseHasDrawn = true
			DrawnCardScoreHouse.emit(DeckValue[DrawnCard-1])
			$HouseHand/Card5.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		6:
			HouseHasDrawn = true
			DrawnCardScoreHouse.emit(DeckValue[DrawnCard-1])
			$HouseHand/Card6.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		7:
			HouseHasDrawn = true
			DrawnCardScoreHouse.emit(DeckValue[DrawnCard-1])
			$HouseHand/Card7.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		8:
			HouseHasDrawn = true
			DrawnCardScoreHouse.emit(DeckValue[DrawnCard-1])
			HouseHandFull.emit()
			$HouseHand/Card8.texture = load("res://Playing Cards/" + DeckTexture[DrawnCard - 1] + ".png")
		


func _on_label_bet_placed():
	GameState = 1
	

func _on_button_button_pressed():
	if GameState == 1:
		GameState = 2

func _on_score_board_game_lost():
	GameLost = true

func _on_score_board_game_won():
	GameWon = true



func _on_score_board_house_wants_draw():
	HouseWantsDraw = true
	pass # Replace with function body.
