extends Area3D

func _ready():
	body_entered.connect(_on_body_entered)
	
# agarar la moneda	
func _on_body_entered(body):
	if body.name == "Player":
		queue_free()
