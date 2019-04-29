extends Sprite

export (PackedScene) var Bullet
export var rate_of_fire = 1.0

var can_shoot = false


func _ready():
	$Firerate.wait_time = rate_of_fire * PlayerVariables.fire_rate_multiplier
	$Firerate.start()


func _process(delta):
	look_at(get_global_mouse_position())
	flip_weapon()
	
	if Input.is_action_pressed("left_click"):
		shoot()


func shoot():
	if can_shoot:
		$ShotSound.play()
		$Firerate.start()
		can_shoot = false
		var direction = Vector2(1, 0).rotated(global_rotation)
		
		var bullet = Bullet.instance()
		Global.current_scene.add_child(bullet)
		bullet.start($Position2D.global_position, direction)
#		bullet.start($Position2D.global_position, (direction * randf()))
#		print(direction)

func _on_Firerate_timeout():
	can_shoot = true

func flip_weapon():
	if global_rotation > -1.5 && 1.5 > global_rotation:
		flip_v = false
	else:
		flip_v = true
