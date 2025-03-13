extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var coins_label: Label = $Camera2D/CoinsLabel


const SPEED = 180.0
const JUMP_VELOCITY = -350.0

#var alive = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gamepdalay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction == 0:
			animation.play("idle")
		else:
			animation.play("run")
			animation.flip_h = direction < 0
	else:
		animation.play("jump")

	move_and_slide()
	
	
func die() -> void:
	collision_shape_2d.queue_free()
