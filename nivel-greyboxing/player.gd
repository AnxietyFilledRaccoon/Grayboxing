extends CharacterBody3D

@export var speed = 14.0
@export var acceleration = 100.0
@export var deceleration = 80.0
@export var rotation_speed = 3.0
@export var max_jumps = 2
@export var fall_acceleration = 75.0
@export var jump_impulse = 20.0
@export var limite_caida = -20.0

var jumps = 0
var target_velocity = Vector3.ZERO
var posicion_inicial = Vector3.ZERO

func _physics_process(delta):
	# resetear saltos
	if is_on_floor():
		jumps = max_jumps
	#sumar saltos
	if Input.is_action_just_pressed("jump") and jumps > 0:
		target_velocity.y = jump_impulse
		jumps -= 1

	# movimiento
	if Input.is_action_pressed("move_left"):
		rotation.y += rotation_speed * delta

	if Input.is_action_pressed("move_right"):
		rotation.y -= rotation_speed * delta

	if global_position.y < limite_caida:
		global_position = posicion_inicial
		target_velocity = Vector3.ZERO
		velocity = Vector3.ZERO

	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z

	if Input.is_action_pressed("move_back"):
		direction += transform.basis.z

	direction.y = 0

	if direction != Vector3.ZERO:
		direction = direction.normalized()

		target_velocity.x = move_toward(
			target_velocity.x,
			direction.x * speed,
			acceleration * delta
		)

		target_velocity.z = move_toward(
			target_velocity.z,
			direction.z * speed,
			acceleration * delta
		)
	else:
		target_velocity.x = move_toward(
			target_velocity.x,
			0,
			deceleration * delta
		)

		target_velocity.z = move_toward(
			target_velocity.z,
			0,
			deceleration * delta
		)

	# gravedad base
	if not is_on_floor():
		target_velocity.y -= fall_acceleration * delta

	# activar movimiento
	velocity = target_velocity
	move_and_slide()
