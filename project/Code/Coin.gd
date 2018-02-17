extends Area2D

var sound

func _ready():
	sound = $Sound


func _on_Coin_body_entered( body ):
	sound.play()
	$AnimatedSprite.play("Collect")
	$CollisionShape2D.disabled = true
