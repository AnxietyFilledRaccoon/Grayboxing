extends AnimatableBody3D

@export var distance = 5.0
@export var speed = 2.0
@export var direction = Vector3.RIGHT


var start_position = Vector3.ZERO
var time = 0.0

func _ready():
	start_position = position

func _physics_process(delta):
	time += delta

# ajustar en Inspector para donde se mueve la plataforma
	var movement = sin(time * speed) * distance
	position = start_position + direction * movement
