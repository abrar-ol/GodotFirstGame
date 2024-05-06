extends Area2D

@onready var timer = $Timer
var jumpEvents=[];

func _on_body_entered(body):
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()

	jumpEvents=InputMap.action_get_events("jump")
	InputMap.action_erase_events("jump")

	timer.start()
	
func _on_timer_timeout():
	Engine.time_scale = 1.0
	_add_event("jump",jumpEvents)
	get_tree().reload_current_scene()

func _add_event(action,events):
	for event in events:
		InputMap.action_add_event(action,event)
