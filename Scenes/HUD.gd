extends CanvasLayer

signal new_game
signal show_game_over_end

func update_score(value):
	value = cast_to_persian_number(value)
	$MarginContainer/ScoreLabel.text = str(value)

func update_timer(value):
	#print("time is: " + str(value))
	value = cast_to_persian_number(value)
	$MarginContainer/TimeLabel.text = str(value)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("new_game")

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	emit_signal("show_game_over_end")
	$StartButton.show()
	$MessageLabel.text = "Coin Dash!"
	$MessageLabel.show()

func cast_to_persian_number(value):
	var finalStr : String = ""
	var myStr : String = str(value)
	var myChars : Array = []
	for c in myStr:
		myChars.push_back(c)
	for mychar in myChars:
		if mychar == "0":
			finalStr += "٠"
		if mychar == "1":
			finalStr += "١"
		if mychar == "2":
			finalStr += "٢"
		if mychar == "3":
			finalStr += "٣"
		if mychar == "4":
			finalStr += "٤"
		if mychar == "5":
			finalStr += "٥"
		if mychar == "6":
			finalStr += "٦"
		if mychar == "7":
			finalStr += "٧"
		if mychar == "8":
			finalStr += "٨"
		if mychar == "9":
			finalStr += "٩"
	#print(finalStr)
	return finalStr
