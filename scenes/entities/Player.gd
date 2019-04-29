extends KinematicBody2D

var speed = 60
export var normal_speed = 60
export var dash_speed = 400

var mp_weapon = preload("res://scenes/objects/weapons/MP_Weapon.tscn")
var pistol_weapon = preload("res://scenes/objects/weapons/Pistol_Weapon.tscn")
var shotgun_weapon = preload("res://scenes/objects/weapons/Shotgun_Weapon.tscn")
var rocket_launcher_weapon = preload("res://scenes/objects/weapons/RocketLauncher_Weapon.tscn")
var sniper_weapon = preload("res://scenes/objects/weapons/Sniper_Weapon.tscn")

enum Directions{
	UP,
	DOWN,
	SIDE
}
var last_direction = Directions.DOWN

var current_weapon_instance = null

var can_dash = false

func _ready():
	speed = normal_speed
	play_animation(Vector2())
	if !PlayerVariables.current_weapon == PlayerVariables.Weapons.None:
		switch_weapon(PlayerVariables.current_weapon)
	$DashCooldown.start()


func _process(delta):
	if PlayerVariables.health <= 0:
		die()
	var velocity = Vector2()
	
	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1
		last_direction = Directions.UP
		$AnimatedSprite.z_index = 1
		if !$Footsteps.is_playing():
			$Footsteps.playing = true
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1
		last_direction = Directions.DOWN
		$AnimatedSprite.z_index = 0
		if !$Footsteps.is_playing():
			$Footsteps.playing = true
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
		last_direction = Directions.SIDE
		$AnimatedSprite.z_index = 0
		if !$Footsteps.is_playing():
			$Footsteps.playing = true
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
		last_direction = Directions.SIDE
		$AnimatedSprite.z_index = 0
		if !$Footsteps.is_playing():
			$Footsteps.playing = true
	
	if !Input.is_action_pressed("walk_right") && !Input.is_action_pressed("walk_left") && !Input.is_action_pressed("walk_down") && !Input.is_action_pressed("walk_up"):
		$Footsteps.playing = false
	
	if Input.is_action_just_pressed("dash") && can_dash:
		dash()
	
	if Input.is_action_just_pressed("interact"):
		if PlayerVariables.inside_buy_area:
			switch_weapon(PlayerVariables.current_weapon)
			PlayerVariables.inside_buy_area = false
	
	if Input.is_action_just_pressed("switch_weapon"):
		switch_weapon(PlayerVariables.second_weapon)
		PlayerVariables.set_current_weapon(PlayerVariables.second_weapon)
	
#	if Input.is_action_just_pressed("esc"):
##		add_child(load("res://scenes/objects/weapons/MP_Weapon.tscn").instance())
#		Global.switch_scene_to("res://scenes/levels/ArenaLevel.tscn")
	
	velocity = (velocity.normalized() * speed)
	play_animation(velocity)
	move_and_slide(velocity)

func die():
	queue_free()
	Global.switch_scene_to("res://scenes/levels/GameOverScreen.tscn")
	Sounds.play_arena_music(false)
	Sounds.play_shop_music(false)

func dash():
	$DashSound.pitch_scale = rand_range(0.9, 1.1)
	$DashSound.play()
	$DashDuration.start()
	speed = dash_speed
	can_dash = false

func _on_DashDuration_timeout():
	speed = normal_speed
	$DashCooldown.start()

func _on_DashCooldown_timeout():
	can_dash = true

func play_animation(velocity):
	var animation_prefix
	if PlayerVariables.health > 75:
		animation_prefix = "100"
	if PlayerVariables.health <= 75:
		animation_prefix = "75"
	if PlayerVariables.health <= 50:
		animation_prefix = "50"
	if PlayerVariables.health <= 25:
		animation_prefix = "25"
	
	if velocity.x < 0:
		$AnimatedSprite.play(animation_prefix + "WalkSide")
		$AnimatedSprite.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite.play(animation_prefix + "WalkSide")
		$AnimatedSprite.flip_h = false
	elif velocity.y < 0:
		$AnimatedSprite.play(animation_prefix + "WalkUp")
	elif velocity.y > 0:
		$AnimatedSprite.play(animation_prefix + "WalkDown")
	else:
		if last_direction == Directions.UP:
			$AnimatedSprite.play(animation_prefix + "IdleUp")
		if last_direction == Directions.DOWN:
			$AnimatedSprite.play(animation_prefix + "IdleDown")
		if last_direction == Directions.SIDE:
			$AnimatedSprite.play(animation_prefix + "IdleSide")

func take_damage(damage):
	$HitSound.pitch_scale = rand_range(0.8, 1.2)
	$HitSound.play()
	PlayerVariables.health -= damage

func switch_weapon(weapon):
	if current_weapon_instance != null:
		current_weapon_instance.queue_free()
		current_weapon_instance = null
	match weapon:
		PlayerVariables.Weapons.MP:
			current_weapon_instance = mp_weapon.instance()
			add_child(current_weapon_instance)
		PlayerVariables.Weapons.Pistol:
			current_weapon_instance = pistol_weapon.instance()
			add_child(current_weapon_instance)
		PlayerVariables.Weapons.Shotgun:
			current_weapon_instance = shotgun_weapon.instance()
			add_child(current_weapon_instance)
		PlayerVariables.Weapons.RocketLauncher:
			current_weapon_instance = rocket_launcher_weapon.instance()
			add_child(current_weapon_instance)
		PlayerVariables.Weapons.Sniper:
			current_weapon_instance = sniper_weapon.instance()
			add_child(current_weapon_instance)
		PlayerVariables.Weapons.None:
			current_weapon_instance = null
