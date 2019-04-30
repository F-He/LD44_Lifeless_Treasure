extends KinematicBody2D

export (int) var speed = 10
export (int) var damage
export (float) var lifetime = 1.0 

var velocity = Vector2()

func _ready():
	$Lifetime.wait_time = lifetime

func _process(delta):
	position += velocity * delta

func start(_position, _direction):
	$Lifetime.start()
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


func _on_Lifetime_timeout():
	queue_free()
