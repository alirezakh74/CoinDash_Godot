extends Node

export (PackedScene) var Coin
export (PackedScene) var Powerup
export (int) var playtime

var level
var score
var time_left
var screensize
var playing = false

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screenSize = screensize
	$Player.hide()
	
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_coins()
		$PowerupTimer.wait_time = rand_range(3, 8)
		$PowerupTimer.start()
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStartPos.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)
	
func spawn_coins():
	for i in range(4 + level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(20, screensize.x - 20), rand_range(20, screensize.y - 20))
		$LevelSound.play()


func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()
	$EndSound.play()

func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()

func _on_Player_pickup(type):
	match type:
		"coin":
			score += 1
			$HUD.update_score(score)
			$CoinSound.play()
		"powerup":
			time_left += 5
			$HUD.update_timer(time_left)
			$PowerupSound.play()

func _on_Player_hurt():
	game_over()


func _on_HUD_show_game_over_end():
	$Player.hide()


func _on_PowerupTimer_timeout():
	var p = Powerup.instance()
	add_child(p)
	p.screensize = screensize
	p.position = Vector2(rand_range(20, screensize.x - 20), rand_range(20, screensize.y - 20))


func _on_HUD_exit_game():
	get_tree().quit()
