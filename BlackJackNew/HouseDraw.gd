extends PathFollow2D

var MoveCard
var Draw = true
signal card_move_finish


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if MoveCard:
		self.progress_ratio += 0.014
		
	if self.progress_ratio > 0.99:
		self.progress_ratio = 0
		MoveCard = false
		card_move_finish.emit()


func _on_main_game_loop_house_hand_full():
	Draw = false



func _on_main_game_loop_play_animation_house():
	if Draw:
		MoveCard = true

