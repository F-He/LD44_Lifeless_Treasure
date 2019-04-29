extends KinematicBody2D

export var speed = 50
export var damage = 5
export var lifetime = 4.0
export (bool) var rotate = false
export var rotation_speed = 2
var velocity = Vector2()

func _ready():
	$Lifetime.wait_time = lifetime
	$Lifetime.start()

func _process(delta):
	if rotate:
		rotation_degrees += rotation_speed
		if rotation_degrees >= 1080 or rotation_degrees <= -1080:
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
