extends KinematicBody2D

var projectile01 = preload("res://scenes/Entities/SlimeProjectile01.tscn")
var projectile02 = preload("res://scenes/Entities/SlimeProjectile02.tscn")
var projectile03 = preload("res://scenes/Entities/SlimeProjectile03.tscn")
var projectile04 = preload("res://scenes/Entities/SlimeProjectile04.tscn")

var max_health = 20000
var health = 20000

enum Phases {
	one,
	two,
	three,
	four,
	five,
	none
}
var current_phase = Phases.none

var shot_direction = 0
var can_shoot = false

var target = null
var target_direction = null

func _ready():
	$Firerate.wait_time = 0.1
	$Firerate.start()
	$PhaseTimer.wait_time = 2
	$PhaseTimer.start()
	$PhaseTimer.wait_time = 15
	$AnimatedSprite.play("shooting")
	$AnimatedSprite.playing = true
	HUD.show_boss_healthbar(true)
	HUD.change_boss_health_label("Slime Boss: %s Health" % health)
	HUD.change_boss_health_value(health, max_health)


func _process(delta):
	HUD.change_boss_health_label("Slime Boss: %s Health" % health)
	HUD.change_boss_health_value(health, max_health)
	shot_direction += 1
	if can_shoot:
		can_shoot = false
		match current_phase:
			Phases.one:
				phase_one()
			Phases.two:
				phase_two()
			Phases.three:
				phase_three()
			Phases.four:
				phase_four()
			Phases.five:
				phase_five()
			Phases.none:
				pass
	if target:
		target_direction = (Vector2(target.global_position.x, target.global_position.y - 15) - global_position).normalized()
	if health <= 0:
		die()
	if health <= 5000:
		modulate = Color(1, 0.12, 0.12, 1)


func take_damage(damage):
	$HitSound.play()
	health -= damage


func phase_one():
	$Firerate.wait_time = 0.2
	var shoot_directions = [0, 45, 90, 135, 180, 225, 270, 315]
	
	if target:
		shoot(projectile03, target_direction.angle())
	
	for i in shoot_directions:
		shoot(projectile01, deg2rad(i))

func phase_two():
	$Firerate.wait_time = 0.1
	var shoot_directions = [0, -180, -90, 90]
	
	for i in shoot_directions:
		shoot(projectile01, deg2rad(shot_direction + i))


func phase_three():
	var shoot_directions = [0, -180, -90, 90]
	$Firerate.wait_time = 0.10
	
	if target:
		for i in shoot_directions:
			shoot(projectile02, deg2rad(rad2deg(target_direction.angle()) + i))

func phase_four():
	var shoot_directions = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360]
	$Firerate.wait_time = 2
	
	for i in shoot_directions:
		shoot(projectile04, deg2rad(i))

func phase_five():
	var shoot_directions = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360]
	$Firerate.wait_time = 1
	
	for i in shoot_directions:
		shoot(projectile04, deg2rad(i))
	if target:
		shoot(projectile03, target_direction.angle())

func shoot(projectile, _direction):
	if current_phase == Phases.five:
		$Firerate.wait_time = rand_range(0.1, 1)
	var direction = Vector2(1, 0).rotated(_direction)
	var p = projectile.instance()
	Global.current_scene.add_child(p)
	p.start($Position2D.global_position, direction)

func switch_phase(phase = null):
	if phase == null:
		match current_phase:
			Phases.one:
				current_phase = Phases.two
			Phases.two:
				current_phase = Phases.three
			Phases.three:
				current_phase = Phases.four
			Phases.four:
				current_phase = Phases.five
			Phases.five:
				current_phase = Phases.one
				$PhaseTimer.wait_time = 5
			Phases.none:
				current_phase = Phases.one
	else:
		current_phase = phase


func die():
	HUD.show_boss_healthbar(false)
	Sounds.play_slime_boss_death_sound()
	queue_free()


func _on_Firerate_timeout():
	can_shoot = true

func _on_PhaseTimer_timeout():
	switch_phase()


func _on_DetectRadius_body_entered(body):
	if body.name == "Player":
		target = body


func _on_DetectRadius_body_exited(body):
	if body.name == "Player":
		target = null
