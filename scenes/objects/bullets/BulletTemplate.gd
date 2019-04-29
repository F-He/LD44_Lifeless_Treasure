extends KinematicBody2D

export (int) var speed = 10
export (int) var damage

var velocity = Vector2()

func _process(delta):
	position += velocity * delta

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	velocity = _direction * speed

func on_body_hit(body):
	queue_free()
	body.take_damage(damage)

func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		on_body_hit(body)


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	queue_free()
