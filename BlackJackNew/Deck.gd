extends Area2D

var Cursor_On_Deck = false
signal Click_On_Deck



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_click") and Cursor_On_Deck:
		Click_On_Deck.emit()




func _on_mouse_entered():
	Cursor_On_Deck = true
	pass # Replace with function body.


func _on_mouse_exited():
	Cursor_On_Deck = false
	pass # Replace with function body.
