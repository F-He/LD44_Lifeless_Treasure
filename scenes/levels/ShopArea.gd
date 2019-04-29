extends Node2D

var mp_cost = 25
var pistol_cost = 10
var shotgun_cost = 40
var rocket_launcher_cost = 50
var sniper_cost = 50
var rate_of_fire_power_up_cost = 40

enum WeaponAreas {
	MP_Area,
	Pistol_Area,
	Shotgun_Area,
	RocketLauncher_Area,
	Sniper_Area,
	Rate_Of_Fire_Power_up_Area,
	None
}

var current_area = WeaponAreas.None

func _ready():
	Sounds.play_shop_music()
	HUD.show_enemies_left(false)
	HUD.show()

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if current_area != WeaponAreas.None:
			match current_area:
				WeaponAreas.MP_Area:
					PlayerVariables.set_current_weapon(PlayerVariables.Weapons.MP)
					$ShopItems/MP.queue_free()
					PlayerVariables.health -= mp_cost
					$PickupSound.play()
				WeaponAreas.Pistol_Area:
					PlayerVariables.set_current_weapon(PlayerVariables.Weapons.Pistol)
					$ShopItems/Pistol.queue_free()
					PlayerVariables.health -= pistol_cost
					$PickupSound.play()
				WeaponAreas.Shotgun_Area:
					PlayerVariables.set_current_weapon(PlayerVariables.Weapons.Shotgun)
					$ShopItems/Shotgun.queue_free()
					PlayerVariables.health -= shotgun_cost
					$PickupSound.play()
				WeaponAreas.RocketLauncher_Area:
					PlayerVariables.set_current_weapon(PlayerVariables.Weapons.RocketLauncher)
					$ShopItems/RocketLauncher.queue_free()
					PlayerVariables.health -= rocket_launcher_cost
					$PickupSound.play()
				WeaponAreas.Sniper_Area:
					PlayerVariables.set_current_weapon(PlayerVariables.Weapons.Sniper)
					$ShopItems/Sniper.queue_free()
					PlayerVariables.health -= sniper_cost
					$PickupSound.play()
				WeaponAreas.Rate_Of_Fire_Power_up_Area:
					PlayerVariables.fire_rate_multiplier -= 0.5
					$ShopItems/RateOfFirePowerUp.queue_free()
					PlayerVariables.health -= rate_of_fire_power_up_cost
					$PickupSound.play()

func is_player(body):
	return body.name == "Player"

# Dialog with TheDeath
func _on_Interact_body_entered(body):
	if is_player(body):
		HUD.show_dialog(true, "Welcome.\nTrade your life for goods.\nBut be aware, you can only hold 2 Weapons at the same time. Press Q to switch weapons")

func _on_Interact_body_exited(body):
	if is_player(body):
		HUD.show_dialog(false)


func _on_MP_buy_area_body_entered(body):
	if is_player(body):
		HUD.show_dialog(true, "Machine Pistol:\nCost: %s Health\nPress E to buy." % mp_cost)
		current_area = WeaponAreas.MP_Area
		PlayerVariables.inside_buy_area = true


func _on_Pistol_buy_area_body_entered(body):
	if is_player(body):
		HUD.show_dialog(true, "Pistol:\nCost:  %s Health\nPress E to buy." % pistol_cost)
		current_area = WeaponAreas.Pistol_Area
		PlayerVariables.inside_buy_area = true


func _on_Shotgun_buy_area_body_entered(body):
	if is_player(body):
		HUD.show_dialog(true, "Shotgun:\nCost:  %s Health\nPress E to buy." % shotgun_cost)
		current_area = WeaponAreas.Shotgun_Area
		PlayerVariables.inside_buy_area = true


func _on_RocketLauncher_buy_area_body_entered(body):
	if is_player(body):
		HUD.show_dialog(true, "Rocket Launcher:\nCost:  %s Health\nPress E to buy." % rocket_launcher_cost)
		current_area = WeaponAreas.RocketLauncher_Area
		PlayerVariables.inside_buy_area = true


func _on_Sniper_buy_area_body_entered(body):
	if is_player(body):
		HUD.show_dialog(true, "Sniper Rifle:\nCost:  %s Health\nPress E to buy." % sniper_cost)
		current_area = WeaponAreas.Sniper_Area
		PlayerVariables.inside_buy_area = true


func _on_Rate_Of_Fire_buy_area_body_entered(body):
	if is_player(body):
		HUD.show_dialog(true, "Rate of Fire Power Up:\nCost: %s Health\nPress E to buy." % rate_of_fire_power_up_cost)
		current_area = WeaponAreas.Rate_Of_Fire_Power_up_Area


func _on_buy_area_body_exited(body):
	if is_player(body):
		HUD.show_dialog(false)
		current_area = WeaponAreas.None
		PlayerVariables.inside_buy_area = true


func _on_DoorArea_body_entered(body):
	if is_player(body):
		Sounds.play_shop_music(false)
		Global.switch_scene_to("res://scenes/levels/ArenaLevel.tscn")


