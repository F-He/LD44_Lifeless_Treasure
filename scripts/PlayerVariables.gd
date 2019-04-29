extends Node

enum Weapons {
	MP,
	Pistol,
	Shotgun,
	RocketLauncher,
	Sniper,
	None
}

var health = 100
var current_weapon = Weapons.None
var second_weapon = Weapons.None
var inside_buy_area = false

# Needs to get decreased to increase the rate of fire
var fire_rate_multiplier = 1

func reset():
	health = 100
	current_weapon = Weapons.None
	second_weapon = Weapons.None
	fire_rate_multiplier = 1

func set_current_weapon(weapon):
	match current_weapon:
		Weapons.MP:
			second_weapon = Weapons.MP
		Weapons.Pistol:
			second_weapon = Weapons.Pistol
		Weapons.Shotgun:
			second_weapon = Weapons.Shotgun
		Weapons.RocketLauncher:
			second_weapon = Weapons.RocketLauncher
		Weapons.Sniper:
			second_weapon = Weapons.Sniper
		Weapons.None:
			second_weapon = Weapons.None
	match weapon:
		Weapons.MP:
			current_weapon = Weapons.MP
		Weapons.Pistol:
			current_weapon = Weapons.Pistol
		Weapons.Shotgun:
			current_weapon = Weapons.Shotgun
		Weapons.RocketLauncher:
			current_weapon = Weapons.RocketLauncher
		Weapons.Sniper:
			current_weapon = Weapons.Sniper
		Weapons.None:
			current_weapon = Weapons.None