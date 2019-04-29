extends KinematicBody2D

export var speed = 25
export var damage = 7
export var lifetime = 6.0
var velocity = Vector2()

func _ready():
	$Lifetime.wait_time = lifetime
	$Lifetime.start()

func _process(delta):
	rotation_degrees += 2
	if rotation_degrees >= 1080:
		rotation_degrees = 0
	position += velocity * delta


func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	velocity = _direction * speed


func on_body_hit(body):
	queue_free()
	body.take_damage(damage)


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage") and body.name == "Player":
		on_body_hit(body)

func _on_Lifetime_timeout():
	queue_free()
