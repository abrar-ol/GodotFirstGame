extends Area2D

# delete coin on body entered
func _on_body_entered(body):
	queue_free()
	body._increase_max_jump(2)
	
