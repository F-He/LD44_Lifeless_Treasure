extends KinematicBody2D

var health = 75
var damage = 2
var speed = 0
var velocity

var target = null
var target_direction = null

func _ready():
	randomize()
	
	$JumpCooldown.wait_time = rand_range(0.0, 2.0)
	$JumpCooldown.start()

func _process(delta):
	if health <= 0:
		die()
	
	if target:
		if target_direction == null:
			target_direction = (Vector2(target.global_position.x, target.global_position.y) - global_position).normalized()
		velocity = target_direction * speed
		position += velocity * delta
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite.flip_h = false

func take_damage(damage):
	health -= damage
	$HitSound.play()

func die():
	Sounds.play_insect_death_sound()
	queue_free()

func _on_DamageRadius_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		die()


func _on_DetectArea_body_entered(body):
	if body.name == "Player":
		target = body


func _on_DetectArea_body_exited(body):
	if body.name == "Player":
		target = null


func _on_JumpTimer_timeout():
	speed = 0
	$JumpCooldown.wait_time = rand_range(0.0, 4.0)
	$JumpCooldown.start()


func _on_JumpCooldown_timeout():
	if target != null:
		target_direction = (Vector2(target.global_position.x, target.global_position.y) - global_position).normalized()
	speed = 400
	$JumpTimer.start()
