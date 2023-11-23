extends Area2D

var screensize
var pickedup = false

func _ready():
	$Tween.interpolate_property($AnimatedSprite, 'scale', $AnimatedSprite.scale, $AnimatedSprite.scale * 3, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($AnimatedSprite, 'modulate', Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$AnimTimer.wait_time = rand_range(2, 5)
	$AnimTimer.start()

func pickup():
	pickedup = true
	monitoring = false
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()


func _on_Powerup_area_entered(area):
	if area.is_in_group("obstacles"):
		position = Vector2(rand_range(20, screensize.x - 20), rand_range(20, screensize.y - 20))


func _on_Lifetime_timeout():
	if !pickedup:
		queue_free()


func _on_AnimTimer_timeout():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play()
