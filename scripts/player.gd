extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -300.0
var  max_jump = 1
var jump_counter = 0
var isDoubleJump = false

@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _change_max_jump(maxJump:int):
	max_jump=maxJump

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() || jump_counter>max_jump: 
		jump_counter = 0
		isDoubleJump=false
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_counter < max_jump:
		jump_counter += 1
		velocity.y = JUMP_VELOCITY

	# Direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
 	# flip player right or left
	if direction < 0 :
		animated_sprite.flip_h = true
	elif  direction > 0:
		animated_sprite.flip_h = false

		
		
	# Handle Movement animation
	if is_on_floor():
		if direction == 0 : 
			animated_sprite.play("idle")
		else :
			animated_sprite.play("move")
			
	else:
		if Input.is_action_just_pressed("jump")and jump_counter==2 && !isDoubleJump:
			animated_sprite.play("doubleJump")
			isDoubleJump = true
		elif jump_counter==1 :
			animated_sprite.play("jump")
				

	move_and_slide()

