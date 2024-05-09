extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var game_manager = %GameManager

# delete coin on body entered
func _on_body_entered(body):
	game_manager.add_point()
	animation_player.play("pickup")

