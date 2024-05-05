extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -300.0
const  MAX_JUMPS = 2
var jump_counter = 0



@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $AnimatedSprite2D/Timer


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Reset jump_counter
	if is_on_floor() : 
		jump_counter=0
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_counter<MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_counter += 1


	# Direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Handle Movement animation
	if is_on_floor():
		if direction == 0 : 
			animated_sprite.play("idle")
		else :
			animated_sprite.play("move")
			if direction < 0 :
				animated_sprite.flip_h = true
			else :
				animated_sprite.flip_h = false
	else:
		if jump_counter == 2 :
			animated_sprite.play("doubleJump")
		else : 
			animated_sprite.play("jump") 


	move_and_slide()
