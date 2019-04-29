extends KinematicBody2D

var health = 100
var damage = 5
var speed = 40
var velocity

var target = null
var target_direction = null

func _ready():
	randomize()
	$DashCooldown.wait_time = rand_range(2.0, 8.0)
	$DashTimer.start()

func _process(delta):
	if health <= 0:
		die()
	
	if target:
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
	Sounds.play_slime_minion_death_sound()
	queue_free()

func _on_DetectArea_body_entered(body):
	if body.name == "Player":
		target = body


func _on_DetectArea_body_exited(body):
	if body.name == "Player":
		target = null


func _on_DashTimer_timeout():
	speed = 40
	$DashCooldown.start()


func _on_DashCooldown_timeout():
	speed = 400
	$DashTimer.start()

func _on_DamageRadius_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		die()
