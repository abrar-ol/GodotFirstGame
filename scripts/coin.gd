extends Area2D

@onready var animation_player = $AnimationPlayer

# delete coin on body entered
func _on_body_entered(body):
	animation_player.play("pickup")

