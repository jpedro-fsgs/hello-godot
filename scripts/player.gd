extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var coin_audio: AudioStreamPlayer2D = $CoinAudio


const SPEED = 180.0
const JUMP_VELOCITY = -350.0

var coin_count: int = 0
var alive: bool = true

func increase_coins() -> void:
	coin_count += 1
	coin_audio.play()
	print(coin_count)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gamepdalay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animation.flip_h = direction < 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
func die() -> bool:
	if not alive:
		return false
	alive = false
	velocity = Vector2.ZERO
	velocity.y = JUMP_VELOCITY
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	return true
