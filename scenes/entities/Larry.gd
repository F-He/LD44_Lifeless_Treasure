extends KinematicBody2D

var projectile06 = preload("res://scenes/entities/Projectile06.tscn")

var insect = preload("res://scenes/entities/Insect.tscn")

onready var spawn_points = [
	$SpawnPoints/SpawnPoint01, $SpawnPoints/SpawnPoint02, $SpawnPoints/SpawnPoint03, $SpawnPoints/SpawnPoint04, 
	$SpawnPoints/SpawnPoint05, $SpawnPoints/SpawnPoint06, $SpawnPoints/SpawnPoint07, $SpawnPoints/SpawnPoint08, 
	]
var max_health = 2000
var health = 2000
var speed = 50

var velocity = Vector2()

var can_shoot = false

func _ready():
	$Firerate.start()
	$MoveCooldown.start()
	$SpawnCooldown.start()


func _process(delta):
	$Healthbar.value = health * 100 / max_health
	if health <= 0:
		die()
	velocity = velocity.normalized() * speed
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite.playing = true
	else:
		$AnimatedSprite.playing = false
	
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	move_and_slide(velocity)
	
	if can_shoot:
		var shoot_directions = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360]
		for i in shoot_directions:
			shoot(projectile06, deg2rad(i))

func die():
	queue_free()
	Sounds.play_larry_death_sound()

func shoot(projectile, _direction):
	can_shoot = false
	$Firerate.wait_time = rand_range(0.5, 4.0)
	$Firerate.start()
	var direction = Vector2(1, 0).rotated(_direction)
	var p = projectile.instance()
	Global.current_scene.add_child(p)
	p.start($Position2D.global_position, direction)

func _on_MoveTimer_timeout():
	velocity = Vector2()
	$MoveCooldown.wait_time = rand_range(0.0, 8.0)
	$MoveCooldown.start()


func _on_MoveCooldown_timeout():
	velocity = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	$MoveTimer.wait_time = rand_range(0.0, 5.0)
	$MoveTimer.start()


func take_damage(damage):
	$HitSound.play()
	health -= damage


func _on_Firerate_timeout():
	can_shoot = true


func _on_SpawnCooldown_timeout():
	for i in range(8):
		modulate = Color(0.89, 0.28, 0.28, 1.0)
		yield(get_tree().create_timer(0.1), 'timeout')
		modulate = Color(1.0, 1.0, 1.0, 1.0)
		yield(get_tree().create_timer(0.1), 'timeout')
	for point in spawn_points:
		var new_insect = insect.instance()
		new_insect.position = point.global_position
		get_parent().add_child(new_insect)
	$SpawnCooldown.start()
