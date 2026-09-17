extends Marker3D

@export var rotation_speed = 20.0

@onready var player = $"../Player"

func _process(delta):
	# seguir al pj
	global_position = player.global_position

	# para que la camara quede atras del pj
	var target_rotation = player.global_rotation.y

	# para que la camara no se descajete
	rotation.y = lerp_angle(
		rotation.y,
		target_rotation,
		rotation_speed * delta
	)
